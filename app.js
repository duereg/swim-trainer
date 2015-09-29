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
var csrf = require('./middleware/csrf');
var users = require('./middleware/users');
var rememberRequest = require('./middleware/rememberRequest');

var app = express();

mongoose.connect(secrets.db);
mongoose.connection.on('error', function() {
  console.error('MongoDB Connection Error. Make sure MongoDB is running.');
});

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
app.use(csrf);
app.use(lusca.xssProtection(true));
app.use(users);

app.use(rememberRequest);

app.use(express.static(path.join(__dirname, 'public'), { maxAge: 3600000 * 24 * 7 }));
app.use(routes);
app.use(errorHandler());

module.exports = app;
