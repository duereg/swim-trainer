# @cjsx React.DOM

React = require('react')
flux = require('src/flux')
storeWatchMixin = require('src/flux/storeWatchMixin')

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
    workoutStore = flux().store('WorkoutStore')
    workout = {id: null}

    if workoutStore?
      workout = workoutStore.workout

    {
      error: workoutStore.error
      workouts: workoutStore.sortedWorkouts()
      workout: workout
    }

  saveWorkout: ->
    flux().actions.save(this.state.workout)

  render: ->
    <form className='processWorkout form-horizontal' role="form">
      <Row>
        <Col sm={12}>
          <workoutDate date={@state.workout.date} />
        </Col>
      </Row>
          {
            @state.workout?.formatted?.sets?.map (set, index) ->
              <Row key={"#{set.name}#{index}"}>
                Set
                {
                  set.intervals.map (interval, index) ->
                    <readOnlyInterval key={index} interval={interval} />
                }
              </Row>
          }
      <editableInterval />
      <hr/>
      <Row>
        <Col sm={12}>
          <button id='process' ref='process' onClick={this.saveWorkout} className='btn btn-primary form-control processWorkout--execute'>Save Workout</button>
        </Col>
      </Row>
    </form>

processWorkout.containerId = containerId

module.exports = processWorkout
