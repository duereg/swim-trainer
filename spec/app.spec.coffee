request = require 'supertest'
app = require '../app.js'

describe 'GET /', ->
  it 'should return 200 OK', (done) ->
    request(app).get('/').expect 200, done

describe 'GET /login', ->
  it 'should return 200 OK', (done) ->
    request(app).get('/login').expect 200, done

describe 'GET /random-url', ->
  it 'should return 404', (done) ->
    request(app).get('/reset').expect 404, done
