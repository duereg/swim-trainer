# @cjsx React.DOM

'use strict'

React = require('react')
formGroup = require('./formGroup.cjsx')
workoutDate = require('./workoutDate.cjsx')
workoutLength = require('./workoutLength.cjsx')
workoutType = require('./workoutType.cjsx')
{Col, Row} = require('react-bootstrap')

containerId = "workout-simple-add"

processWorkout = React.createClass
  render: ->
    <form className='processWorkout form-horizontal' role="form">
      <Row>
        <Col sm={12}>
          <workoutDate date={this.props.data.workout.date} />
        </Col>
      </Row>
      <hr />
      <Row>
        <Col sm={6}>
          <workoutType />
        </Col>
        <Col sm={4} >
          <workoutLength />
        </Col>
        <Col sm={2} >
          <button id='addRow' ref='addRow' className='btn btn-success form-control processWorkout--addRow'>Add</button>
        </Col>
      </Row>
      <hr/>
      <Row>
        <Col sm={12}>
          <button id='process' ref='process' className='btn btn-primary form-control processWorkout--execute'>Save Workout</button>
        </Col>
      </Row>
    </form>

processWorkout.containerId = containerId

module.exports = processWorkout
