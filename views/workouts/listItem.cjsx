# @cjsx React.DOM

React = require('react')
timeFormatter = require('swim-parser/lib/timeFormatter')
dateFormatterMixin = require('../mixins/dateFormatter.coffee')

workoutListItem = React.createClass
  mixins: [dateFormatterMixin]

  render: ->
    workout = this.props.workout
    parsedWorkout = this.props.parsedWorkout

    <section className="Workouts--item" key={workout._id} >
      <div className='row'>
        <div className='col-xs-4 hidden-sm hidden-md hidden-lg'>
          <a href={"/workouts/edit/#{workout._id}"}>{@getFormattedDate(workout.date)}</a>
        </div>
        <div className='col-sm-2 hidden-xs'>
          <a href={"/workouts/edit/#{workout._id}"}>{@getFormattedDate(workout.date)}</a>
        </div>
        <div className='col-xs-2 hidden-sm hidden-md hidden-lg'>Total Distance:</div>
        <div className='col-sm-1 hidden-xs'>Total Distance:</div>
        <div className='col-xs-2 hidden-sm hidden-md hidden-lg'>{parsedWorkout.totalDistance()}</div>
        <div className='col-sm-1 hidden-xs'>{parsedWorkout.totalDistance()}</div>
        <div className='col-xs-2 hidden-sm hidden-md hidden-lg'>Total Time:</div>
        <div className='col-sm-1 hidden-xs'>Total Time:</div>
        <div className='col-xs-2 hidden-sm hidden-md hidden-lg'>{timeFormatter parsedWorkout.totalTime()}</div>
        <div className='col-sm-1 hidden-xs'>{timeFormatter parsedWorkout.totalTime()}</div>
      </div>
    </section>

module.exports = workoutListItem
