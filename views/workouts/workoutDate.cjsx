# @cjsx React.DOM

React = require('react')
dateFormatterMixin = require('../mixins/dateFormatter.coffee')
formGroup = require('./formGroup.cjsx')

workoutDate = React.createClass
  mixins: [dateFormatterMixin]

  render: ->
    <formGroup inputSize={10} labelSize={2} inputId="workout-date" label="Workout Date">
      <input id="workout-date" className='form-control workout-date' type='date' ref='workoutDate' defaultValue={
        if this.props.date? then @getFormattedDate(new Date(this.props.date)) else @getFormattedDate(new Date())
      } />
    </formGroup>

module.exports = workoutDate
