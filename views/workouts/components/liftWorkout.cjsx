# @cjsx React.DOM

React = require('react')
flux = require('src/flux')
storeWatchMixin = require('src/flux/storeWatchMixin')

formGroup = require('./formGroup.cjsx')
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
        <Col sm={4}>
          <liftField fieldName='Reps'
                     defaultValue='10'
                     changeAmount='1'
                     value={this.props.interval?.reps} />
        </Col>
        <Col sm={4}>
          <liftField fieldName='Weight'
                     defaultValue='135'
                     changeAmount='5'
                     value={this.props.interval?.weight} />
        </Col>
        <Col sm={4}>
          <fieldset className='lift-field'>
            <legend>Lift Type</legend>
            <input className='lift-field--value__full'
                   type='text'
                   value={this.props.interval?.type} />
          </fieldset>
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
