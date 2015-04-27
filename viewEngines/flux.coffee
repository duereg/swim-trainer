'use strict'

reactViews = require 'express-coffee-react-views'
flux = require '../src/flux'
secrets = require '../config/secrets'

engine = reactViews.createEngine(beautify: not secrets.isProduction)

pageRenderer = (filename, options, cb) ->
  flux options
  engine filename, options, cb

module.exports = pageRenderer
