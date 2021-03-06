# @cjsx React.DOM

React = require('react')
layout = require('../layout')
simpleWorkout = require('./components/simpleWorkout')

addWorkout = React.createClass
  render: ->
    <layout data={this.props}>
      <div id={simpleWorkout.containerId}>
        <simpleWorkout data={this.props} />
      </div>
    </layout>

module.exports = addWorkout
