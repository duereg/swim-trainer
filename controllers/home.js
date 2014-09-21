/**
 * GET /
 * Home page.
 */

var quotes = require('../models/quotes');

var getRandomInt = function(min, max) {
  return Math.floor(Math.random() * (max - min)) + min;
};

var quoteNum = getRandomInt(0, quotes.length);

exports.index = function(req, res) {
  res.render('home', {
    title: 'Home',
    quote: quotes[quoteNum]
  });
};
