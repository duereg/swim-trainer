# @cjsx React.DOM

React = require('react')
swimParser = require('swim-parser')
_ = require('underscore')

layout = require('../layout')
listItem = require('./listItem')

containerId = "workout-list"

list = React.createClass

  render: ->
    <layout data={this.props} containerId={containerId} >
      <h1> Workouts </h1>
      <div className="container">
        <div className="Workouts">
        {
          _(this.props.workouts).chain().sortBy((workout) -> workout.date).map( (workout) ->
            <listItem key={workout._id} workout={workout} parsedWorkout={swimParser workout.raw} />
          ).value().reverse()
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
