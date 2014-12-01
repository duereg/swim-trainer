# @cjsx React.DOM

React = require('react')
workoutLength = require('./workoutLength.cjsx')
workoutType = require('./workoutType.cjsx')
{Col, Row} = require('react-bootstrap')

editableInterval = React.createClass
  render: ->
    <Row>
      <Col sm={6}>
        <workoutType />
      </Col>
      <Col sm={4} >
        <workoutLength />
      </Col>
      <Col sm={2} >
        <button id='addRow' ref='addRow' className='btn btn-success form-control'>Add</button>
      </Col>
    </Row>

module.exports = editableInterval
