'use strict';

/**
 * GET /
 * Home page.
 */

var quotes = require('../models/quotes');

exports.index = function(req, res) {
  res.render('home', {
    title: 'Home',
    quotes: quotes
  });
};
