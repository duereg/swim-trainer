# @cjsx React.DOM

React = require('react')
layout = require('../layout')

list = React.createClass
  render: ->
    <layout data={this.props} >
      <h1> Workouts </h1>
      <div className="container">
        <div className="Workouts">
        {this.props.workouts.map (workout) ->
          <div>{workout.toString()}</div>
        }
        </div>
        <hr />
        <div className="Workouts--actions">
          <a href="/workouts/add">Add Workout</a>
        </div>
      </div>
    </layout>

module.exports = list
