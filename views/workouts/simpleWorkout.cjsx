# @cjsx React.DOM

'use strict'

React = require('react')
flux = require('../../src/flux')
storeWatchMixin = require('../../src/flux/storeWatchMixin')

formGroup = require('./formGroup.cjsx')
workoutDate = require('./workoutDate.cjsx')
editableInterval = require('./editableInterval.cjsx')
readOnlyInterval = require('./readOnlyInterval.cjsx')
{Col, Row} = require('react-bootstrap')

containerId = "workout-simple-add"

processWorkout = React.createClass
  mixins: [storeWatchMixin('WorkoutStore')],

  getInitialState: ->
    {}

  getStateFromFlux: ->
    console.log "1"
    workoutStore = flux().store('WorkoutStore')
    console.log "2"
    workout = {id: null}

    console.log "3"
    if workoutStore?
      workout = workoutStore.workout

    console.log "4"
    return {
      error: workoutStore.error
      workouts: workoutStore.sortedWorkouts()
      workout: workout
    }

  render: ->
    <form className='processWorkout form-horizontal' role="form">
      <Row>
        <Col sm={12}>
          <workoutDate date={@state.workout.date} />
        </Col>
      </Row>
          {
            @state.workout?.formatted?.sets?.map (set) ->
              <Row>
                Set
                {
                  set.intervals.map (interval) ->
                    <readOnlyInterval interval={interval} />
                }
              </Row>
          }
      <editableInterval />
      <hr/>
      <Row>
        <Col sm={12}>
          <button id='process' ref='process' className='btn btn-primary form-control processWorkout--execute'>Save Workout</button>
        </Col>
      </Row>
    </form>

processWorkout.containerId = containerId

module.exports = processWorkout
