request = require 'supertest'

describe 'app.js', ->
  @timeout(5000)

  {server} = {}

  before (done) ->
    app = require '../app.js'
    server = app.listen app.get('port'), done

  after (done) ->
    server.close done

  describe 'GET /', ->
    it 'should return 200 OK', (done) ->
      request(server).get('/').expect 200, done

  describe 'GET /login', ->
    it 'should return 200 OK', (done) ->
      request(server).get('/login').expect 200, done

  describe 'GET /random-url', ->
    it 'should return 404', (done) ->
      request(server).get('/reset').expect 404, done
