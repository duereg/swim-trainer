promiseAgent = require('./promiseAgent')

methods =
  create: (workout, csrf) ->
    return Promise.reject(new Error('Invalid workout')) unless workout?
    return Promise.reject(new Error('Invalid CSRF token')) unless csrf?
    promiseAgent(csrf)('post', '/v1/workouts/', { workout: workout })

  delete: (workout, csrf) ->
    return Promise.reject(new Error('Invalid workout')) unless workout?
    return Promise.reject(new Error('Invalid CSRF token')) unless csrf?
    promiseAgent(csrf)('del', "/v1/workouts/#{workout._id}", { workout: workout })

  update: (workout, csrf) ->
    return Promise.reject(new Error('Invalid workout')) unless workout?
    return Promise.reject(new Error('Invalid CSRF token')) unless csrf?
    promiseAgent(csrf)('post', "/v1/workouts/#{workout._id}", { workout: workout })

module.exports = methods
