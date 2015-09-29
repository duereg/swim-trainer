'use strict';

require('coffee-react/register');

/**
 * Module dependencies.
 */
var express = require('express');
var cookieParser = require('cookie-parser');
//Uncomment to compress HTML
var compress = require('compression');
var session = require('express-session');
var bodyParser = require('body-parser');
var logger = require('morgan');
var errorHandler = require('errorhandler');
var lusca = require('lusca');
var csrf = lusca.csrf();
var methodOverride = require('method-override');

var _ = require('underscore');
var MongoStore = require('connect-mongo')({ session: session });
var path = require('path');
var mongoose = require('mongoose');
var passport = require('passport');
var expressValidator = require('express-validator');
var connectAssets = require('connect-assets');
var reactFluxViews = require('./viewEngines/flux');
var routes = require('./routes');
var secrets = require('./config/secrets');

var app = express();

mongoose.connect(secrets.db);
mongoose.connection.on('error', function() {
  console.error('MongoDB Connection Error. Make sure MongoDB is running.');
});

/**
 * CSRF whitelist.
 */

var csrfExclude = ['/url1', '/url2'];

/**
 * Express configuration.
 */

app.set('port', secrets.port);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'cjsx');
app.engine('cjsx', reactFluxViews);

if (secrets.isProduction) {
  app.use(compress());
}
app.use(connectAssets({
  paths: [
    path.join(__dirname, 'public/css'),
    path.join(__dirname, 'public/js'),
    path.join(__dirname, 'public/img')
  ],
  helperContext: app.locals
}));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(expressValidator());
app.use(methodOverride());
app.use(cookieParser());
app.use(session({
  resave: true,
  saveUninitialized: true,
  secret: secrets.sessionSecret,
  store: new MongoStore({
    'url': secrets.db,
    'auto_reconnect': true
  })
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(function(req, res, next) {
  // CSRF protection.
  if (_(csrfExclude).contains(req.path)) { return next(); }
  csrf(req, res, next);
});
app.use(lusca.xssProtection(true));
app.use(function(req, res, next) {
  // Make user object available in templates.
  res.locals.user = req.user;
  next();
});

app.use(function(req, res, next) {
  // Remember original destination before login.
  var path = req.path.split('/')[1];
  if (/auth|login|logout|signup|fonts|favicon/i.test(path)) {
    return next();
  }
  req.session.returnTo = req.path;
  next();
});

app.use(express.static(path.join(__dirname, 'public'), { maxAge: 3600000 * 24 * 7 }));
app.use(routes);
app.use(errorHandler());

module.exports = app;
