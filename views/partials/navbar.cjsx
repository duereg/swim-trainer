# @cjsx React.DOM

React = require('react')

userMenu = require('./userMenu.cjsx')

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
            <span className="ion-ios7-stopwatch-outline"></span>
            Swim Trainer
          </a>
        </div>
        <div className="collapse navbar-collapse">
          <ul className="nav navbar-nav">
            <li className={ if this.props.data.title == 'Home' then 'active' else ''}>
              <a href="/">Home</a>
            </li>
            <li className={ if this.props.data.title == 'Workouts' then 'active' else ''}>
              <a href="/workouts">Workouts</a>
            </li>
          </ul>
          <userMenu data={this.props.data} />
        </div>
      </div>
    </div>

module.exports = navBar

