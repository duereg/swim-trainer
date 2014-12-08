# @cjsx React.DOM

React = require('react')
workoutLength = require('./workoutLength.cjsx')
workoutType = require('./workoutType.cjsx')
{Col, Row} = require('react-bootstrap')

editableInterval = React.createClass
  addRow: (ev) ->
    ev.preventDefault()
    console.log 'addRow called'

  render: ->
    <Row>
      <Col sm={6}>
        <workoutType ref='workoutType' />
      </Col>
      <Col sm={4} >
        <workoutLength ref='workoutLength' />
      </Col>
      <Col sm={2} >
        <button id='addRow' ref='addRow' onClick={this.addRow} className='btn btn-success form-control'>Add</button>
      </Col>
    </Row>

module.exports = editableInterval
