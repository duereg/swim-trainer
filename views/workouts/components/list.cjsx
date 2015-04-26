# @cjsx React.DOM

React = require('react')
_ = require('underscore')

listItem = require('./listItem')
{Table, Row, Col} = require('react-bootstrap')
flux = require('src/flux')
storeWatchMixin = require('src/flux/storeWatchMixin')

containerId = "workout-list"

list = React.createClass
  mixins: [storeWatchMixin('WorkoutStore')],

  getInitialState: ->
    {}

  getStateFromFlux: ->
    workoutStore = flux().store('WorkoutStore')
    workout = {id: null}

    if workoutStore?
      workout = workoutStore.workout

    {
      error: workoutStore.error
      workouts: workoutStore.sortedWorkouts()
      workout: workout
    }

  render: ->
    <div className="container">
      <Row>
        <Col xl={3} lg={4} md={4} xs={10}>
          <Table className="Workouts" condensed>
            <thead>
              <th>Date</th>
              <th>Total Time</th>
              <th>Actions</th>
            </thead>
            <tbody>
              {
                _(this.state.workouts).chain().sortBy((workout) -> workout.date).map( (workout) ->
                  <listItem key={workout._id} workout={workout} />
                ).value().reverse()
              }
            </tbody>
          </Table>
        </Col>
      </Row>
      <hr />
      <div className="Workouts--actions">
        <a href="/workouts/addSimple">Add a cardio workout</a> |&nbsp;
        <a href="/workouts/addLift">Add a weight lift</a> |&nbsp;
        <a href="/workouts/addText">Type in a workout</a> |&nbsp;
      </div>
    </div>

list.containerId = containerId

module.exports = list
