# @cjsx React.DOM

React = require('react')
formGroup = require('./formGroup.cjsx')

intervals = ["0:00","0:15","0:30","0:45","1:00","1:15","1:30","1:45","2:00","2:15","2:30","2:45","3:00","3:30","4:00","4:30","5:00","6:00"]

workoutLength = React.createClass
  optionSelected: (ev) ->
    console.log 'workoutLength', ev.target.value
    this.props.onChange?(ev.target.value)

  currentValue: ->
    console.log 'currentValue: workoutLength', this.refs.lengthSelector
    this.refs.lengthSelector.getDOMNode().value

  render: ->
    <formGroup labelSize={5} inputSize={6} inputId="length-of-workout" label="Length of Workout">
      <select id="length-of-workout" className="form-control" ref="lengthSelector"
        value={this.props.value} onChange={this.optionSelected}>
        {
          intervals.map (interval, index) ->
            <option key={index} value={interval}>{interval}</option>
        }
      </select>
    </formGroup>

module.exports = workoutLength
