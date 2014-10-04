# @cjsx React.DOM

React = require('react')
layout = require('./layout')

home = React.createClass
  render: ->
    <layout title='Wishlist Page'>
      <h1> Swimathon Starter </h1>
      <p className="lead">
        The best thing eating sliced bread in a speedo
      </p>
      <hr />
      <div className="row">
        <div className="col-sm-6">
          p #{this.props.quote.quote}
          p #{this.props.quote.author}
        </div>
      </div>
    </layout>

module.exports = home
