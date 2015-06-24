# @cjsx React.DOM

React = require('react')
layout = require('./layout')
{Col, Row} = require('react-bootstrap')
timeFormatter = require 'fit-parser/lib/timeFormatter'
dateFormatterMixin = require('./mixins/dateFormatter.coffee')

containerId = "home"

home = React.createClass
  mixins: [dateFormatterMixin],

  getQuoteAndImage: ->
    quotes = this.props.quotes
    images = this.props.images
    getRandomInt = (min, max) -> Math.floor(Math.random() * (max - min)) + min
    quoteNum = getRandomInt(0, quotes.length)
    imageNum = getRandomInt(0, images.length)
    { quote: quotes[quoteNum], image: images[imageNum] }

  render: ->
    {quote, image} = @getQuoteAndImage()

    <layout data={this.props} >
      <div containerId={containerId} >
        <Row>
          <Col sm={6}>
            <fieldset>
              <legend>Quote of the Moment</legend>
              <p> {quote.quote} </p>
              <p> {quote.author} </p>
            </fieldset>
          </Col>
          <Col sm={6}>
            <fieldset>
              <legend>Image of the Moment</legend>
              <img alt='funny workout picture' src={'/img/motivation/' + image} />
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
