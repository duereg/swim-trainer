# @cjsx React.DOM

React = require('react')
layout = require('../layout')
{Col, Row} = require('react-bootstrap')

containerId = "login"

home = React.createClass
  render: ->
    <layout title='Wishlist Page' data={this.props} containerId={containerId} >
      <div className='page-header'>
        <h3>Sign in</h3>
      </div>

      <form method='POST'>
        <input type='hidden' name='_csrf' value={this.props._csrf} />
          <Row>
            <Col className='bottom-sm' sm={6}>
              <a className='btn btn-block btn-facebook btn-social' href='/auth/facebook'>
                <i className='fa fa-facebook' /> | Sign in with Facebook
              </a>
            </Col>
          </Row>
          <Row>
            <Col sm={6}>
              <a className='btn btn-block btn-google-plus btn-social' href='/auth/google'>
                <i className='fa fa-google-plus' /> | Sign in with Google
              </a>
            </Col>
          </Row>
      </form>
    </layout>

home.containerId = containerId

module.exports = home




