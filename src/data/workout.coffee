promiseAgent = require('./promiseAgent')

methods =
  create: (date, workout, csrf) ->
    promiseAgent(csrf)('post', '/v1/workouts/', { date: date, workout: workout })

  delete: (workout, csrf) ->
    promiseAgent(csrf)('delete', "/v1/workouts/#{workout._id}", { workout: workout })

  update: (date, workout, csrf) ->
    promiseAgent(csrf)('post', "/v1/workouts/#{workout._id}", { workout: workout })

module.exports = methods
