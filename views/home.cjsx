# @cjsx React.DOM

React = require('react')
layout = require('./layout')
{Col, Row} = require('react-bootstrap')
timeFormatter = require 'fit-parser/lib/timeFormatter'
dateFormatterMixin = require('./mixins/dateFormatter.coffee')

containerId = "home"

home = React.createClass
  mixins: [dateFormatterMixin],

  getQuote: ->
    quotes = this.props.quotes
    getRandomInt = (min, max) -> Math.floor(Math.random() * (max - min)) + min
    quoteNum = getRandomInt(0, quotes.length)
    quotes[quoteNum]

  render: ->
    quote = @getQuote()

    <layout data={this.props} >
      <div containerId={containerId} >

        <Row>
          <Col sm={12}>
            <fieldset>
              <legend>Quote of the Moment</legend>
              <p> {quote.quote} </p>
              <p> {quote.author} </p>
            </fieldset>
          </Col>
        </Row>
        <Row>
          <Col sm={12}>
            <fieldset>
              <legend>Recent Activity</legend>
            {
              this.props.activity.map (activity) =>
                <div>
                  On {@getFormattedDate(new Date(activity.date))}&nbsp;
                  {activity.userFullName} did&nbsp;
                  {timeFormatter.toString(activity.formatted.totalTime())} of work.
                </div>
            }
            </fieldset>
          </Col>
        </Row>
      </div>
      <hr />
    </layout>

home.containerId = containerId

module.exports = home
