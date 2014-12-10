'use strict'

reactViews = require('express-coffee-react-views')
flux = require('../src/flux')
engine = reactViews.createEngine(beautify: true)

pageRenderer = (filename, options, cb) ->
  flux options
  engine filename, options, cb

module.exports = pageRenderer
