# @cjsx React.DOM

React = require('react')
layout = require('../layout')
swimParser = require('swim-parser')
timeFormatter = require('swim-parser/lib/timeFormatter')
dateFormatterMixin = require('../mixins/dateFormatter.coffee')

containerId = "workout-list"

list = React.createClass
  mixins: [dateFormatterMixin]

  render: ->
    <layout data={this.props} containerId={containerId} >
      <h1> Workouts </h1>
      <div className="container">
        <div className="Workouts">
        {
          me = @
          this.props.workouts.map (workout) ->
            parsedWorkout = swimParser workout.raw

            <section className="Workouts--item" key={workout._id} >
              <div className='row'>
                <div className='col-xs-4'>{me.getFormattedDate(workout.date)}</div>
                <div className='col-xs-2'>Total Distance:</div>
                <div className='col-xs-2'>{parsedWorkout.totalDistance()}</div>
                <div className='col-xs-2'>Total Time:</div>
                <div className='col-xs-2'>{timeFormatter parsedWorkout.totalTime()}</div>
              </div>
            </section>
        }
        </div>
        <hr />
        <div className="Workouts--actions">
          <a href="/workouts/add">Add Workout</a>
        </div>
      </div>
    </layout>

list.containerId = containerId

module.exports = list
