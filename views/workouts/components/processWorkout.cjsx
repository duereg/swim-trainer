# @cjsx React.DOM

'use strict'

React = require('react')
workoutData = require('../../../src/data/workout.coffee')
dateFormatterMixin = require('../../mixins/dateFormatter.coffee')
smallRow = require('./smallRow.cjsx')

containerId = "workout-add"

processWorkout = React.createClass
  mixins: [dateFormatterMixin]

  getInitialState: ->
    workout: {}

  processWorkout: ->
    workout = this.refs.workoutInput.getDOMNode().value
    date = this.refs.workoutDate.getDOMNode().value
    promise = null

    if this.props.data.workout?
      this.props.data.workout.raw = workout
      this.props.data.workout.date = date
      promise = workoutData.save(date, this.props.data.workout, this.props.data._csrf)
    else
      promise = workoutData.create(date, workout, this.props.data._csrf)

    promise
      .then (results) ->
        window.location = '/workouts'
      .catch (error) ->
        console.error error

  getCurrentDateFormatted: ->
    today = new Date()
    "#{today.getFullYear()}-#{today.getMonth() + 1}-#{today.getDate()}"

  render: ->
    <div className='processWorkout container'>
      <smallRow>
        Enter your workout
      </smallRow>
      <smallRow>
        <textarea className='processWorkout--input' id='workoutInput' ref='workoutInput' defaultValue={this.props.data.workout?.raw} />
      </smallRow>
      <smallRow>
        <input className='input-sm processWorkout--date' type='date' ref='workoutDate' defaultValue={
          if this.props.data.workout?.date? then @getFormattedDate(new Date(this.props.data.workout.date)) else @getFormattedDate(new Date())
        } />
      </smallRow>
      <smallRow>
        <button id='process' ref='process' className='processWorkout--execute' onClick={this.processWorkout}>Save Workout</button>
      </smallRow>
    </div>

processWorkout.containerId = containerId

module.exports = processWorkout
