# @cjsx React.DOM

'use strict'

React = require('react')
workoutData = require('../../src/data/workout.coffee')
dateFormatterMixin = require('../mixins/dateFormatter.coffee')
buttonGroup = require('./buttonGroup.cjsx')
smallRow = require('./smallRow.cjsx')

containerId = "workout-simple-add"

intervals = [":15", ":30", ":45", "1:00"]

processWorkout = React.createClass
  mixins: [dateFormatterMixin]

  getInitialState: ->
    workout: {}

  getCurrentDateFormatted: ->
    today = new Date()
    "#{today.getFullYear()}-#{today.getMonth() + 1}-#{today.getDate()}"

  render: ->
    <div className='processWorkout container'>
      <smallRow>
        Enter your workout
      </smallRow>
      <smallRow>
        <input className='input-sm processWorkout--date' type='date' ref='workoutDate' defaultValue={
          if this.props.data.workout?.date? then @getFormattedDate(new Date(this.props.data.workout.date)) else @getFormattedDate(new Date())
        } />
      </smallRow>
      <smallRow>
        Practice: <buttonGroup groupName="practice" items={intervals} />
      </smallRow>
      <smallRow>
        Surface w Fins: <buttonGroup groupName="surface-fins" items={intervals} />
      </smallRow>
      <smallRow>
        Surface wo Fins: <buttonGroup groupName="surface-no-fins" items={intervals} />
      </smallRow>
      <smallRow>
        <button id='process' ref='process' className='processWorkout--execute'>Save Workout</button>
      </smallRow>
    </div>

processWorkout.containerId = containerId

module.exports = processWorkout
