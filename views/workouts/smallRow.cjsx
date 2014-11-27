# @cjsx React.DOM

React = require('react')
{Col, Row} = require('react-bootstrap')

smallRow = React.createClass
  render: ->
    <Row className={this.props.className}>
      <Col xs={12}>
        {this.props.children}
      </Col>
    </Row>

module.exports = smallRow
