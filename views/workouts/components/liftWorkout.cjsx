# @cjsx React.DOM

React = require('react')
flux = require('src/flux')
storeWatchMixin = require('src/flux/storeWatchMixin')

workoutDate = require('./workoutDate.cjsx')
liftField = require('./liftField.cjsx')
{Col, Row, Table} = require('react-bootstrap')

containerId = "workout-lift-add"

processWorkout = React.createClass
  mixins: [storeWatchMixin('WorkoutStore')],

  getInitialState: ->
    {}

  getStateFromFlux: ->
    workoutStore = flux().store('WorkoutStore')
    workout = {id: null}

    if workoutStore?
      workout = workoutStore.workout

    {
      error: workoutStore.error
      workouts: workoutStore.sortedWorkouts()
      workout: workout
    }

  saveWorkout: (ev) ->
    ev.preventDefault()
    console.log 'about to save', @state.workout
    flux().actions.save @state.workout

  render: ->
    <form className='processWorkout form-horizontal' role="form">
      <Row>
        <Col sm={6}>
          <liftField fieldName='Reps' value='10' />
        </Col>
      </Row>
      <Row>
        <Col sm={6}>
          <liftField fieldName='Weight' value='135' />
        </Col>
      </Row>
      <hr />
      <Row>
        <Col sm={8}>
          <workoutDate date={@state.workout.date} />
        </Col>
        <Col sm={4}>
          <button id='process' ref='process' onClick={this.saveWorkout} className='btn btn-primary form-control processWorkout--execute'>Save Workout</button>
        </Col>
      </Row>
    </form>

processWorkout.containerId = containerId

module.exports = processWorkout
