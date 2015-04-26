# @cjsx React.DOM

React = require('react')
layout = require('../layout')
liftWorkout = require('./components/liftWorkout')

addWorkout = React.createClass
  render: ->
    <layout data={this.props}>
      <div id={liftWorkout.containerId}>
        <liftWorkout data={this.props} />
      </div>
    </layout>

module.exports = addWorkout
