# @cjsx React.DOM

React = require('react')
layout = require('../layout')
processWorkout = require('./processWorkout')
simpleWorkout = require('./simpleWorkout')

addWorkout = React.createClass
  render: ->
    <layout data={this.props}>
      <div id={simpleWorkout.containerId}>
        <simpleWorkout data={this.props} />
      </div>
    </layout>

module.exports = addWorkout
