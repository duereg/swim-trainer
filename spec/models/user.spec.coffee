{expect, faker} = require '../spec-helper'

User = require('../../models/User')

errorCallback = (done) ->
  (err) ->
    return done(err) if err
    done()

describe 'User Model', ->
  {user, password, email} = {}

  before ->
    email = faker.internet.email()
    password = faker.internet.password()
    user = new User {email, password}

  after (done) ->
    User.remove {email}, errorCallback(done)

  describe 'creating a new user', ->
    it 'is cool', (done) ->
      user.save errorCallback(done)

    describe 'saving same user again', ->
      it 'shouldnt happen with a non-unique email', (done) ->
        user2 = new User {email, password}

        user2.save (err) ->
          err.code.should.equal 11000  if err
          done()

    describe 'then finding user', ->
      it 'should find user by email', (done) ->
        User.findOne {email: user.email}, (err, foundUser) ->
          done(err) if err?

          if foundUser?
            foundUser.email.should.equal user.email
            done()
          else
            done(new Error("no user found with email #{email}")) unless foundUser?

