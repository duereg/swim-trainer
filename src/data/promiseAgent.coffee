Agent = require('superagent')
agentPromisePlugin = require('superagent-promises')

csrf = null

getResultsPromise = (action, url, body) ->
  agent = Agent[action](url)
    .set('Content-Type', 'application/json')
    .set('X-Requested-With', 'XMLHttpRequest')
    .set('x-csrf-token', csrf)
    .withCredentials()

  if body?
    agent = agent.send(body)

  agent.use(agentPromisePlugin).end()

module.exports = (currentCsrf) ->
  csrf = currentCsrf
  getResultsPromise
