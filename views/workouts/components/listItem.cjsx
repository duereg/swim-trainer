# @cjsx React.DOM

React = require('react')
Workout = require('swim-parser/lib/workout')
timeFormatter = require('swim-parser/lib/timeFormatter')
dateFormatterMixin = require('../../mixins/dateFormatter.coffee')

workoutListItem = React.createClass
  mixins: [dateFormatterMixin]

  deleteWorkout: ->
    if confirm("Are you sure you want to delete this workout?")
      flux().actions.delete(this.props.workout)

  render: ->
    workout = this.props.workout
    parsedWorkout = null

    if workout.formatted?
      parsedWorkout = new Workout(workout.formatted)

    <tr className="Workouts--item" key={workout._id} >
      <td>
        <a href={"/workouts/edit/#{workout._id}"}>
          {@getFormattedDate(workout.date)}
        </a>
      </td>
      <td>{ if parsedWorkout? then timeFormatter.toString(parsedWorkout.totalTime()) else '0:00'}</td>
      <td>
        <span className='big-font ion-ios7-close-outline' onClick={this.deleteWorkout}></span>
      </td>
    </tr>

module.exports = workoutListItem
