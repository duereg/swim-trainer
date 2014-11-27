# @cjsx React.DOM

'use strict'

React = require('react')
workoutData = require('../../src/data/workout.coffee')
dateFormatterMixin = require('../mixins/dateFormatter.coffee')
buttonGroup = require('./buttonGroup.cjsx')
formGroup = require('./formGroup.cjsx')
{Col, Row} = require('react-bootstrap')
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
      <Row>
        <Col sm={8}>
          <formGroup inputSize={10} labelSize={2} inputId="processWorkout--date" label="Workout Date">
            <input id="processWorkout--date" className='form-control processWorkout--date' type='date' ref='workoutDate' defaultValue={
              if this.props.data.workout?.date? then @getFormattedDate(new Date(this.props.data.workout.date)) else @getFormattedDate(new Date())
            } />
          </formGroup>
        </Col>
      </Row>
      <Row>
        <Col sm={4}>
          <formGroup inputId="type-of-workout" label="Type of Workout">
            <select id="type-of-workout" className="form-control">
              {
                typesOfWorkouts.map (workout) ->
                  <option key={workout.id} value={workout.id}>{workout.title}</option>
              }
            </select>
          </formGroup>
        </Col>
        <Col sm={4}>
          <formGroup inputId="length-of-workout" label="Length of Workout">
            <select id="length-of-workout" className="form-control">
              {
                intervals.map (interval, index) ->
                  <option key={index} value={interval}>{interval}</option>
              }
            </select>
          </formGroup>
        </Col>
      </Row>
      <Row>
        <Col sm={8}>
          <formGroup inputSize={10} labelSize={2} >
            <button id='process' ref='process' className='btn btn-success form-control processWorkout--execute'>Save Workout</button>
          </formGroup>
        </Col>
      </Row>
    </form>

processWorkout.containerId = containerId

module.exports = processWorkout
