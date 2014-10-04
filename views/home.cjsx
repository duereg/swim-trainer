# @cjsx React.DOM

React = require('react')
layout = require('./layout')

home = React.createClass
  render: ->
    <layout data={this.props} >
      <h1> Swimathon Starter </h1>
      <p className="lead">
        <p> {this.props.quote.quote} </p>
        <p> {this.props.quote.author} </p>
      </p>
      <hr />
      <div className="row">
        <div className="col-sm-12">

        </div>
      </div>
    </layout>

module.exports = home
