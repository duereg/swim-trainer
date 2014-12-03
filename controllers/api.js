'use strict';

var secrets = require('../config/secrets');
var querystring = require('querystring');
var validator = require('validator');
var async = require('async');
var request = require('request');
var graph = require('fbgraph');
var Github = require('github-api');
var stripe =  require('stripe')(secrets.stripe.apiKey);

var _ = require('underscore');

/**
 * GET /api
 * List of API examples.
 */

exports.getApi = function(req, res) {
  res.render('api/index', {
    title: 'API Examples'
  });
};

/**
 * GET /api/facebook
 * Facebook API example.
 */

exports.getFacebook = function(req, res, next) {
  var token = _(req.user.tokens).findWhere({ kind: 'facebook' });
  graph.setAccessToken(token.accessToken);
  async.parallel({
    getMe: function(done) {
      graph.get(req.user.facebook, function(err, me) {
        done(err, me);
      });
    },
    getMyFriends: function(done) {
      graph.get(req.user.facebook + '/friends', function(err, friends) {
        done(err, friends.data);
      });
    }
  },
  function(err, results) {
    if (err) return next(err);
    res.render('api/facebook', {
      title: 'Facebook API',
      me: results.getMe,
      friends: results.getMyFriends
    });
  });
};

/**
 * GET /api/github
 * GitHub API Example.
 */
exports.getGithub = function(req, res) {
  var token = _(req.user.tokens).findWhere({ kind: 'github' });
  var github = new Github({ token: token.accessToken });
  var repo = github.getRepo('sahat', 'requirejs-library');
  repo.show(function(err, repo) {
    res.render('api/github', {
      title: 'GitHub API',
      repo: repo
    });
  });

};

/**
 * GET /api/stripe
 * Stripe API example.
 */

exports.getStripe = function(req, res) {
  res.render('api/stripe', {
    title: 'Stripe API'
  });
};

/**
 * POST /api/stripe
 * @param stipeToken
 * @param stripeEmail
 */

exports.postStripe = function(req, res) {
  var stripeToken = req.body.stripeToken;
  var stripeEmail = req.body.stripeEmail;

  stripe.charges.create({
    amount: 395,
    currency: 'usd',
    card: stripeToken,
    description: stripeEmail
  }, function(err) { // function(err, charge)
    if (err && err.type === 'StripeCardError') {
      req.flash('errors', { msg: 'Your card has been declined.'});
      res.redirect('/api/stripe');
    }
    req.flash('success', { msg: 'Your card has been charged successfully.'});
    res.redirect('/api/stripe');
  });
};

/**
 * GET /api/venmo
 * Venmo API example.
 */

exports.getVenmo = function(req, res, next) {
  var token = _(req.user.tokens).findWhere({ kind: 'venmo' });
  var query = querystring.stringify({ 'access_token': token.accessToken });

  async.parallel({
    getProfile: function(done) {
      request.get({ url: 'https://api.venmo.com/v1/me?' + query, json: true }, function(err, request, body) {
        done(err, body);
      });
    },
    getRecentPayments: function(done) {
      request.get({ url: 'https://api.venmo.com/v1/payments?' + query, json: true }, function(err, request, body) {
        done(err, body);

      });
    }
  },
  function(err, results) {
    if (err) return next(err);
    res.render('api/venmo', {
      title: 'Venmo API',
      profile: results.getProfile.data,
      recentPayments: results.getRecentPayments.data
    });
  });
};

/**
 * POST /api/venmo
 * @param user
 * @param note
 * @param amount
 * Send money.
 */

exports.postVenmo = function(req, res, next) {
  req.assert('user', 'Phone, Email or Venmo User ID cannot be blank').notEmpty();
  req.assert('note', 'Please enter a message to accompany the payment').notEmpty();
  req.assert('amount', 'The amount you want to pay cannot be blank').notEmpty();

  var errors = req.validationErrors();

  if (errors) {
    req.flash('errors', errors);
    return res.redirect('/api/venmo');
  }

  var token = _(req.user.tokens).findWhere({ kind: 'venmo' });
  var userIdKey = 'user_id';

  var formData = {
    'access_token': token.accessToken,
    'note': req.body.note,
    'amount': req.body.amount
  };

  if (validator.isEmail(req.body.user)) {
    formData.email = req.body.user;
  } else if (validator.isNumeric(req.body.user) &&
    validator.isLength(req.body.user, 10, 11)) {
    formData.phone = req.body.user;
  } else {
    formData[userIdKey] = req.body.user;
  }

  request.post('https://api.venmo.com/v1/payments', { form: formData }, function(err, request, body) {
    if (err) return next(err);
    if (request.statusCode !== 200) {
      req.flash('errors', { msg: JSON.parse(body).error.message });
      return res.redirect('/api/venmo');
    }
    req.flash('success', { msg: 'Venmo money transfer complete' });
    res.redirect('/api/venmo');
  });
};
