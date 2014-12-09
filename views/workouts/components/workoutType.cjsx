# @cjsx React.DOM

React = require('react')
formGroup = require('./formGroup.cjsx')

typesOfWorkouts = [
  {id: 'uwh_game', title: 'UWH Game'},
  {id: 'swimming', title: 'Swimming'},
  {id: 'fin_swimming', title: 'Fin Swimming'},
  {id: 'apnea', title: 'Dynamic Apnea'},
  {id: 'puck_skills', title: 'Puck Skills'},

  {id: 'endurance', title: 'Endurance'},
  {id: 'strength', title: 'Strength'},
  {id: 'speed', title: 'Speed'},
  {id: 'agility', title: 'Agility'},
  {id: 'other', title: 'Other'},
]

workoutType = React.createClass
  typeSelected: (ev) ->
    this.props.onChange?(ev.target.value)

  currentValue: ->
    this.refs.typeSelector.getDOMNode().value

  render: ->
    <formGroup inputId="type-of-workout" label="Type of Workout">
      <select ref='typeSelector' id="type-of-workout"
        className="form-control" value={this.props.value} onChange={this.typeSelected} >
        {
          typesOfWorkouts.map (workout) ->
            <option key={workout.id} value={workout.title}>{workout.title}</option>
        }
      </select>
    </formGroup>

module.exports = workoutType
