promiseAgent = require('./promiseAgent')

methods =
  create: (workout, csrf) ->
    throw new Error('Invalid workout') unless workout?
    throw new Error('Invalid CSRF token') unless csrf?
    promiseAgent(csrf)('post', '/v1/workouts/', { workout: workout })

  delete: (workout, csrf) ->
    throw new Error('Invalid workout') unless workout?
    throw new Error('Invalid CSRF token') unless csrf?
    promiseAgent(csrf)('del', "/v1/workouts/#{workout._id}", { workout: workout })

  update: (workout, csrf) ->
    throw new Error('Invalid workout') unless workout?
    throw new Error('Invalid CSRF token') unless csrf?
    promiseAgent(csrf)('post', "/v1/workouts/#{workout._id}", { workout: workout })

module.exports = methods
