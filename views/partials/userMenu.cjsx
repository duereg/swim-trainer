# @cjsx React.DOM

React = require('react');

userMenu = React.createClass
  render: ->
    user = this.props.data.user
    {menu, picture} = {}

    unless user?
      menu =
        <li className={ this.props.data.title == 'Login' ? 'active' : undefined} >
          <a href='/login'>Login</a>
        </li>
    else
      if user.profile?.picture?
        picture = <img src={user.profile?.picture} alt='Profile Picture' />
      else
        picture = <img src={user.gravatar(60)} alt='Gravatar Picture' />

      menu =
        <li className={ if this.props.data.title == 'Account Management' then 'dropdown active' else 'dropdown'}>
          <a href="#" data-toggle="dropdown" className="dropdown-toggle">
            {picture} | {user.profile?.name || user.email || user.id}
            <i className="caret"></i>
          </a>
          <ul className="dropdown-menu">
            <li>
              <a href="/account">
                <span className="ion-person"></span>
                My Account
              </a>
            </li>
            <li className="divider"></li>
            <li>
              <a href="/logout"><span className="ion-log-out"></span>Logout</a>
            </li>
          </ul>
        </li>

    <ul className="nav navbar-nav navbar-right">
      {menu}
    </ul>

module.exports = userMenu
