# @cjsx React.DOM

React = require('react')
flux = require('src/flux')
storeWatchMixin = require('src/flux/storeWatchMixin')

formGroup = require('./formGroup.cjsx')
workoutDate = require('./workoutDate.cjsx')
editableInterval = require('./editableInterval.cjsx')
readOnlyInterval = require('./readOnlyInterval.cjsx')
{Col, Row, Table} = require('react-bootstrap')

containerId = "workout-simple-add"

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
      <editableInterval />
      <Row>
        <Col sm={1} className='hidden-xs'></Col>
        <Col sm={10}>
          <Table className='Intervals' condensed>
            <tbody>
            {
              @state.workout?.formatted?.sets?.map (set, index) ->
                set.intervals.map (interval, index) ->
                  <readOnlyInterval key={index} interval={interval} />
            }
            </tbody>
          </Table>
        </Col>
        <Col sm={1} className='hidden-xs'></Col>
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
