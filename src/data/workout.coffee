Agent = require('superagent')
agentPromisePlugin = require('superagent-promises')

methods =
  create: (date, workout, csrf) ->
    Agent.post('/workouts/add')
      .set('Accept', 'application/json')
      .set('Content-Type', 'application/json')
      .set('X-Requested-With', 'XMLHttpRequest')
      .set('x-csrf-token', csrf)
      .withCredentials()
      .send({ date: date, workout: workout })
      .use(agentPromisePlugin)
      .end()


module.exports = methods
