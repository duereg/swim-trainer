# @cjsx React.DOM

React = require('react')
layout = require('./layout')
{Col, Row} = require('react-bootstrap')

containerId = "home"

home = React.createClass

  getQuote: ->
    quotes = this.props.quotes
    getRandomInt = (min, max) -> Math.floor(Math.random() * (max - min)) + min
    quoteNum = getRandomInt(0, quotes.length)
    quotes[quoteNum]

  render: ->
    quote = @getQuote()

    <layout data={this.props} >
      <div containerId={containerId} >
        <h1> Swim Trainer </h1>
        <p className="lead">
          <p> {quote.quote} </p>
          <p> {quote.author} </p>
        </p>
        <Row>
          List Activity Here
        </Row>
      </div>
      <hr />
    </layout>

home.containerId = containerId

module.exports = home
