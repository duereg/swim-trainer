# @cjsx React.DOM

React = require('react')
layout = require('../layout')
accountLinker = require('./accountLinker')

containerId = "profile"

home = React.createClass
  render: ->
    user = this.props.user

    if user.profile?.picture?
      picture = <img src={user.profile?.picture} width='100' height='100' alt='Profile Picture' className="profile" />
    else
      picture = <img src={user.gravatar()} width='100' height='100' alt='Gravatar Picture' className="profile" />

    <layout data={this.props} containerId={containerId} >
      <div className="page-header">
        <h3>Profile Information
        </h3>
      </div>
      <form action="/account/profile" method="POST" className="form-horizontal">
        <input type="hidden" name="_csrf" value={this.props._csrf} />
        <div className="form-group">
          <label for="email" className="col-sm-2 control-label">Email</label>
          <div className="col-sm-4">
            <input type="email" name="email" id="email" value={user.email} className="form-control" />
          </div>
        </div>
        <div className="form-group">
          <label for="name" className="col-sm-2 control-label">Name</label>
          <div className="col-sm-4">
            <input type="text" name="name" id="name" value={user.profile.name} className="form-control" />
          </div>
        </div>
        <div className="form-group">
          <label for="gender" className="col-sm-2 control-label">
            Gender
          </label>
          <div className="col-sm-4">
            <label className="radio">
              <input type="radio" checked={user.profile.gender=='male'} name="gender" value="male" data-toggle="radio" />
              <span>Male</span>
            </label>
            <label className="radio">
              <input type="radio" name="gender" checked={user.profile.gender=='female'} value="female" data-toggle="radio" />
              <span>Female</span>
            </label>
          </div>
        </div>
        <div className="form-group">
          <label for="location" className="col-sm-2 control-label">
            Location
          </label>
          <div className="col-sm-4">
            <input type="text" name="location" id="location" value={user.profile.location} className="form-control" />
          </div>
        </div>
        <div className="form-group">
          <label for="website" className="col-sm-2 control-label">Website</label>
          <div className="col-sm-4">
            <input type="text" name="website" id="website" value={user.profile.website} className="form-control" />
          </div>
        </div>
        <div className="form-group">
          <label for="gravatar" className="col-sm-2 control-label">Gravatar</label>
          <div className="col-sm-4">
            {picture}
          </div>
        </div>
        <div className="form-group">
          <div className="col-sm-offset-2 col-sm-4">
            <button type="submit" className="btn btn btn-primary">
              <span className="ion-edit"></span>
              Update Profile
            </button>
          </div>
        </div>
      </form>
      <div className="page-header">
        <h3>Delete Account</h3>
      </div>
      <p>You can delete your account, but keep in mind this action is irreversible.</p>
      <form action="/account/delete" method="POST">
        <input type="hidden" name="_csrf" value={this.props._csrf} />
        <button type="submit" className="btn btn-danger">
          <span className="ion-trash-b"></span>
          Delete my account
        </button>
      </form>
      <div className="page-header">
        <h3>Linked Accounts</h3>
      </div>
      <p>
        <accountLinker account={user.google} accountName={'Google'} />
      </p>
      <p>
        <accountLinker account={user.facebook} accountName={'Facebook'} />
      </p>
    </layout>

home.containerId = containerId

module.exports = home




