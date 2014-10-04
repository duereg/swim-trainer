# @cjsx React.DOM

React = require('react')

userMenu = require('./navbar/userMenu.cjsx')

navBar = React.createClass
  render: ->
    <div className="navbar navbar-default navbar-fixed-top">
      <div className="container">
        <div className="navbar-header">
          <button type="button" data-toggle="collapse" data-target=".navbar-collapse" className="navbar-toggle">
            <span className="sr-only">Toggle navigation</span>
            <span className="icon-bar"></span>
            <span className="icon-bar"></span>
            <span className="icon-bar"></span>
          </button>
          <a href="/" className="navbar-brand">
            <span className="ion-cube"></span>
            Project name
          </a>
        </div>
        <div className="collapse navbar-collapse">
          <ul className="nav navbar-nav">
            <li className="active">
              <a href="/">Home</a>
            </li>
            <li>
              <a href="/api">API Examples</a>
            </li>
          </ul>
          <userMenu data={this.props.data} />
        </div>
      </div>
    </div>

module.exports = navBar

