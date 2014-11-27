# @cjsx React.DOM

'use strict'


      # <smallRow>
      #   <h3>Swimming</h3>
      #   <div className='col-xs-12'>
      #     UWH Game: <buttonGroup groupName="practice" items={intervals} />
      #   </div>
      #   <div className='col-xs-12'>
      #     Swimming: <buttonGroup groupName="swimming" items={intervals} />
      #   </div>
      #   <div className='col-xs-12'>
      #     Fin Swimming: <buttonGroup groupName="fin-swimming" items={intervals} />
      #   </div>
      #   <div className='col-xs-12'>
      #     Dynamic Apnea: <buttonGroup groupName="apnea" items={intervals} />
      #   </div>
      #   <div className='col-xs-12'>
      #     Puck Skills: <buttonGroup groupName="puck-skills" items={shortIntervals} />
      #   </div>
      # </smallRow>
      # <smallRow>
      #   <h3>Fitness</h3>
      #   <div>
      #     <div className='col-xs-12'>
      #       Endurance: <buttonGroup groupName="endurance" items={intervals} />
      #     </div>
      #     <div className='col-xs-12'>
      #       Strength: <buttonGroup groupName="strength" items={intervals} />
      #     </div>
      #     <div className='col-xs-12'>
      #       Speed: <buttonGroup groupName="speed" items={intervals} />
      #     </div>
      #     <div className='col-xs-12'>
      #       Agility: <buttonGroup groupName="agility" items={intervals} />
      #     </div>
      #     <div className='col-xs-12'>
      #       Other: <buttonGroup groupName="other-fitness" items={intervals} />
      #     </div>
      #   </div>
      # </smallRow>


      # <formGroup className="hidden-xs" inputId="btnIntervals" label="Length of Workout">
      #   <DropdownButton id="btnIntervals" ref='btnIntervals' className="form-control" onSelect={this.onIntervalSelect}>
      #     {
      #       intervals.map (interval, index) ->
      #         <MenuItem key={index} eventKey={index}>{interval}</MenuItem>
      #     }
      #   </DropdownButton>
      # </formGroup>


      # <formGroup label="Length of Workout">
      #   <autocomplete options={intervals.map (interval)-> {id: interval, title: interval} } />
      # </formGroup>

React = require('react')
workoutData = require('../../src/data/workout.coffee')
dateFormatterMixin = require('../mixins/dateFormatter.coffee')
buttonGroup = require('./buttonGroup.cjsx')
formGroup = require('./formGroup.cjsx')
smallRow = require('./smallRow.cjsx')
panelBox = require('./panelBox.cjsx')
# dropDown = require('./dropDown.cjsx')
# <dropDown items={intervals} />
{DropdownButton, MenuItem} = require('react-bootstrap')
autocomplete = require('ron-react-autocomplete')

containerId = "workout-simple-add"

intervals = ["0:00","0:15","0:30","0:45","1:00","1:15","1:30","1:45","2:00","2:15","2:30","2:45","3:00","3:30","4:00","4:30","5:00","6:00"]
shortIntervals = ["0:05", "0:10", "0:15", "0:20", "0:25", "0:30", "0:35", "0:40", "0:45", "0:50", "0:55", "1:00"]

typesOfWorkouts = [
  {id: 'uwh_game', title: 'UWH Game'},
  {id: 'swimming', title: 'Swimming'},
  {id: 'fin_swimming', title: 'Fin Swimming'},
  {id: 'strawberry', title: 'Dynamic Apnea'},
  {id: 'puck_skills', title: 'Puck Skills'},

  {id: 'endurance', title: 'Endurance'},
  {id: 'strength', title: 'Strength'},
  {id: 'speed', title: 'Speed'},
  {id: 'agility', title: 'Agility'},
  {id: 'other', title: 'Other'},
]

processWorkout = React.createClass
  mixins: [dateFormatterMixin]

  getInitialState: ->
    workout: {}

  onIntervalSelect: (key) ->
    interval = intervals[key]
    @refs.btnIntervals.props.title = interval

  getCurrentDateFormatted: ->
    today = new Date()
    "#{today.getFullYear()}-#{today.getMonth() + 1}-#{today.getDate()}"

  render: ->
    <form className='processWorkout form-horizontal' role="form">
      <formGroup inputId="processWorkout--date" label="Workout Date">
        <input id="processWorkout--date" className='form-control processWorkout--date' type='date' ref='workoutDate' defaultValue={
          if this.props.data.workout?.date? then @getFormattedDate(new Date(this.props.data.workout.date)) else @getFormattedDate(new Date())
        } />
      </formGroup>
      <formGroup inputId="type-of-workout" label="Type of Workout">
        <select id="type-of-workout" className="form-control">
          {
            typesOfWorkouts.map (workout) ->
              <option key={workout.id} value={workout.id}>{workout.title}</option>
          }
        </select>
      </formGroup>
      <formGroup inputId="length-of-workout" label="Length of Workout">
        <select id="length-of-workout" className="form-control">
          {
            intervals.map (interval, index) ->
              <option key={index} value={interval}>{interval}</option>
          }
        </select>
      </formGroup>
      <formGroup>
        <button id='process' ref='process' className='btn btn-success form-control processWorkout--execute'>Save Workout</button>
      </formGroup>
    </form>

processWorkout.containerId = containerId

module.exports = processWorkout
