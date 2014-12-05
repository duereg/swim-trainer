# @cjsx React.DOM

React = require('react')
{Col, Row} = require('react-bootstrap')

editableInterval = React.createClass
  render: ->
    <Row>
      <Col sm={10}>
        <span>{this.props.interval.type}</span>
        <span>{this.props.interval.time}</span>
      </Col>
      <Col sm={2} >
        <button id='deleteInterval' ref='deleteInterval' className='btn btn-error form-control'>Delete</button>
      </Col>
    </Row>

module.exports = editableInterval
