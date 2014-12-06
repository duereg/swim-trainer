# @cjsx React.DOM

React = require('react')
swimParser = require('swim-parser')
timeFormatter = require('swim-parser/lib/timeFormatter')
dateFormatterMixin = require('../../mixins/dateFormatter.coffee')

workoutListItem = React.createClass
  mixins: [dateFormatterMixin]

  deleteWorkout: ->
    if confirm("Are you sure you want to delete this workout?")
      flux().actions.delete(this.props.workout)

  render: ->
    workout = this.props.workout
    parsedWorkout = swimParser workout.raw

    <tr className="Workouts--item" key={workout._id} >
      <td>
        <a href={"/workouts/edit/#{workout._id}"}>
          {@getFormattedDate(workout.date)}
        </a>
      </td>
      <td>{timeFormatter.toString parsedWorkout.totalTime()}</td>
      <td>
        <span className='big-font ion-ios7-close-outline' onClick={this.deleteWorkout}></span>
      </td>
    </tr>

module.exports = workoutListItem
