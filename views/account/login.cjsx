# @cjsx React.DOM

React = require('react')
layout = require('../layout')

home = React.createClass
  render: ->
    <layout title='Wishlist Page' data={this.props} >
      <div className='page-header'>
        <h3>Sign in</h3>
      </div>

      <form method='POST'>
        <input type='hidden' name='_csrf' value={this.props._csrf} />
        <div className='col-sm-8 col-sm-offset-2' >
          <a className='btn btn-block btn-facebook btn-social' href='/auth/facebook'>
            <i className='fa fa-facebook' /> | Sign in with Facebook
          </a>
          <a className='btn btn-block btn-google-plus btn-social' href='/auth/google'>
            <i className='fa fa-google-plus' /> | Sign in with Google
          </a>
        </div>
      </form>
    </layout>

module.exports = home




