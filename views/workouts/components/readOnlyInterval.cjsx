# @cjsx React.DOM

React = require('react')
{Col, Row} = require('react-bootstrap')
timeFormatter = require 'fit-parser/lib/timeFormatter'
flux = require('src/flux')

editableInterval = React.createClass
  deleteInterval: (ev) ->
    ev.preventDefault()
    flux().actions.deleteInterval(this.props.interval)

  render: ->
    <tr className='Intervals--item' key={this.props.interval.type + this.props.interval.time} >
      <td>
        <span className='form-control-static'>{this.props.interval.type}</span>
      </td>
      <td>
        <span className='form-control-static'>{timeFormatter.toString this.props.interval.time}</span>
      </td>
      <td>
        <span id='deleteInterval' ref='deleteInterval'
          className='big-font ion-ios7-close-outline' onClick={this.deleteInterval}></span>
      </td>
    </tr>
module.exports = editableInterval
