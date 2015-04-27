# @cjsx React.DOM

'use strict'

React = require('react')
flux = require('src/flux')
storeWatchMixin = require('src/flux/storeWatchMixin')

dateFormatterMixin = require('../../mixins/dateFormatter.coffee')
smallRow = require('./smallRow.cjsx')

containerId = "workout-add"

processWorkout = React.createClass
  mixins: [dateFormatterMixin, storeWatchMixin('WorkoutStore')],

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
    workout = @state.workout
    workout.raw = this.refs.workoutInput.getDOMNode().value
    workout.date = this.refs.workoutDate.getDOMNode().value

    flux().actions.save(@state.workout)

  render: ->
    <div className='processWorkout container'>
      <smallRow>

      </smallRow>
      <smallRow>
        <fieldset>
        <legend>Enter your workout</legend>
          <input className='form-control processWorkout--date' type='date' ref='workoutDate' defaultValue={
            if this.state.workout?.date? then @getFormattedDate(new Date(this.state.workout.date)) else @getFormattedDate(new Date())
          } />
        </fieldset>
      </smallRow>
      <smallRow>
        <textarea className='form-control processWorkout--input' id='workoutInput' ref='workoutInput' defaultValue={this.state.workout?.raw} />
      </smallRow>
      <smallRow>
        <button id='process' ref='process' className='btn btn-primary form-control processWorkout--execute' onClick={this.saveWorkout}>Save Workout</button>
      </smallRow>
    </div>

processWorkout.containerId = containerId

module.exports = processWorkout
