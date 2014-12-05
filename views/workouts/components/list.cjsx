# @cjsx React.DOM

React = require('react')
_ = require('underscore')

listItem = require('./listItem')
{Table, Row, Col} = require('react-bootstrap')

containerId = "workout-list"

list = React.createClass
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
                _(this.props.data.workouts).chain().sortBy((workout) -> workout.date).map( (workout) ->
                  <listItem key={workout._id} workout={workout} />
                ).value().reverse()
              }
            </tbody>
          </Table>
        </Col>
      </Row>
      <hr />
      <div className="Workouts--actions">
        <a href="/workouts/add">Add Workout</a>
      </div>
    </div>

list.containerId = containerId

module.exports = list
