# @cjsx React.DOM

React = require('react')
layout = require('../layout')

containerId = "workout-list"

list = React.createClass
  render: ->
    <layout data={this.props} containerId={containerId} >
      <h1> Workouts </h1>
      <div className="container">
        <div className="Workouts">
        {this.props.workouts.map (workout) ->
          <div>{workout.raw}</div>
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
