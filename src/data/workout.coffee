promiseAgent = require('./promiseAgent')

methods =
  create: (date, workout, csrf) ->
    promiseAgent(csrf)('post', '/workouts/add', { date: date, workout: workout })

  save: (date, workout, csrf) ->
    #shouldn't need date as workout should contain it?
    promiseAgent(csrf)('post', "workouts/save/#{workout._id}", {workout: workout})

module.exports = methods
