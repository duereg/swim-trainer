var _ = require('underscore');
var lusca = require('lusca');
var csrf = lusca.csrf();

var csrfExclude = ['/url1', '/url2'];

module.exports = function(req, res, next) {
  // CSRF protection.
  if (_(csrfExclude).contains(req.path)) { return next(); }
  csrf(req, res, next);
}
