# @cjsx React.DOM

React = require('react')
formGroup = require('./formGroup.cjsx')

intervals = ["0:00","0:15","0:30","0:45","1:00","1:15","1:30","1:45","2:00","2:15","2:30","2:45","3:00","3:30","4:00","4:30","5:00","6:00"]

workoutLength = React.createClass
  optionSelected: (ev) ->
    this.props.onChange?(ev.target.value)

  currentValue: ->
    this.refs.lengthSelector.getDOMNode().value

  render: ->
    <fieldset>
      <legend>Length of Workout</legend>
      <select id="length-of-workout" className="form-control" ref="lengthSelector"
        value={this.props.value} onChange={this.optionSelected}>
        {
          intervals.map (interval) ->
            <option key={interval} value={interval + ':00'}>{interval}</option>
        }
      </select>
    </fieldset>

module.exports = workoutLength
