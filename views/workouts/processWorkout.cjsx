# @cjsx React.DOM

'use strict'

React = require('react')
swimParser = require('swim-parser')

containerId = "workout-add"

processWorkout = React.createClass
  getInitialState: ->
    workout: {}

  processWorkout: ->
    value = this.refs.workoutInput.getDOMNode().value
    output = swimParser value
    console.log output
    this.setState workout: output

  render: ->
    <div className='container'>
      <div className='row'>
        <div className='col-xs-6'>
          Enter your swim workout
        </div>
        <div className='col-xs-6'>
          Results
        </div>
      </div>
      <div className='row'>
        <div className='col-xs-6'>
          <textarea id='workoutInput' ref='workoutInput' />
        </div>
        <div className='col-xs-6'>
          <div id='output' ref='output'>{this.state.workout.toString()}</div>
        </div>
      </div>
      <div className='row'>
        <div className='col-xs-12'>
          <button id='process' ref='process' onClick={this.processWorkout}>Process Workout</button>
        </div>
      </div>
    </div>

processWorkout.containerId = containerId

module.exports = processWorkout
