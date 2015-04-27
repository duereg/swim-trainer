# @cjsx React.DOM

React = require('react')
flux = require('src/flux')
dateFormatterMixin = require('../../mixins/dateFormatter.coffee')
formGroup = require('./formGroup.cjsx')

workoutDate = React.createClass
  mixins: [dateFormatterMixin]

  dateChanged: ->
    console.log 'UI: update date', this.refs.workoutDate.getDOMNode().value
    flux().actions.updateDate this.refs.workoutDate.getDOMNode().value

  render: ->
    <fieldset>
      <legend>Workout Date</legend>
      <input className='form-control workout-date'
        type='date' ref='workoutDate' onChange={this.dateChanged}
        defaultValue={
          if this.props.date? then @getFormattedDate(new Date(this.props.date)) else @getFormattedDate(new Date())
        } />
    </fieldset>

module.exports = workoutDate
