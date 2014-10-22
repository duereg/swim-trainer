# @cjsx React.DOM

'use strict'

React = require('react')
workoutData = require('../../src/data/workout.coffee')
dateFormatterMixin = require('../mixins/dateFormatter.coffee')

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
      # console.log(this.props.data.workout)
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
      <div className='row'>
        <div className='col-xs-6'>
          Enter your workout
        </div>
      </div>
      <div className='row'>
        <div className='col-xs-6'>
          <textarea className='processWorkout--input' id='workoutInput' ref='workoutInput' defaultValue={this.props.data.workout?.raw} />
        </div>
      </div>
      <div className='row'>
        <div className='col-xs-6'>
          <input className='input-sm processWorkout--date' type='date' ref='workoutDate' defaultValue={
            if this.props.data.workout?.date? then @getFormattedDate(new Date(this.props.data.workout.date)) else @getFormattedDate(new Date())
          } />
        </div>
      </div>
      <div className='row'>
        <div className='col-xs-6'>
          <button id='process' ref='process' className='processWorkout--execute' onClick={this.processWorkout}>Save Workout</button>
        </div>
      </div>
    </div>

processWorkout.containerId = containerId

module.exports = processWorkout
