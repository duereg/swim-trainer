# @cjsx React.DOM

React = require('react')

layout = require('../layout')
list = require('./components/list')

index = React.createClass
  render: ->
    <layout data={this.props} >
      <h1> Workouts </h1>
      <div id={list.containerId}>
        <list data={this.props} />
      </div>
    </layout>

module.exports = index
