# @cjsx React.DOM

React = require('react');

userMenu = React.createClass
  render: ->
    account = this.props.account
    accountName = this.props.accountName

    unless account?
      <a href={"/auth/#{accountName.toLowerCase()}"}>
        Link your {accountName} account
      </a>
    else
      <a href={"/account/unlink/#{accountName.toLowerCase()}"} className="text-danger">
        Unlink your {accountName} account
      </a>


module.exports = userMenu
