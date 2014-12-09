# @cjsx React.DOM

React = require('react')
flux = require('src/flux')
workoutLength = require('./workoutLength.cjsx')
workoutType = require('./workoutType.cjsx')
{Col, Row} = require('react-bootstrap')

editableInterval = React.createClass
  addRow: (ev) ->
    ev.preventDefault()
    type = @refs.workoutType.currentValue()
    length = @refs.workoutLength.currentValue()

    console.log 'addRow called', this.refs.workoutType.currentValue(), this.refs.workoutLength.currentValue()
    flux().actions.addInterval(type, length)

  render: ->
    <Row>
      <Col sm={4}>
        <workoutType ref='workoutType' onChange={this.typeChanged} />
      </Col>
      <Col sm={4}>
        <workoutLength ref='workoutLength' onChange={this.lengthChanged} />
      </Col>
      <Col sm={4}>
        <button id='addRow' ref='addRow' onClick={this.addRow} className='btn btn-success form-control'>Add</button>
      </Col>
    </Row>

module.exports = editableInterval
