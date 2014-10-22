# @cjsx React.DOM

React = require('react')
swimParser = require('swim-parser')

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
          this.props.workouts.map (workout) ->
            <listItem workout={workout} parsedWorkout={swimParser workout.raw} />
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
