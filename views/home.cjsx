# @cjsx React.DOM

React = require('react')
layout = require('./layout')

home = React.createClass

  getQuote: ->
    quotes = this.props.quotes
    getRandomInt = (min, max) -> Math.floor(Math.random() * (max - min)) + min
    quoteNum = getRandomInt(0, quotes.length)
    quotes[quoteNum]

  render: ->
    quote = @getQuote()

    <layout data={this.props} >
      <h1> Swimathon Starter </h1>
      <p className="lead">
        <p> {quote.quote} </p>
        <p> {quote.author} </p>
      </p>
      <hr />
    </layout>

module.exports = home
