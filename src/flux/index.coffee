Fluxxor = require('fluxxor')

WorkoutStore = require('./workout/store')
workoutActions = require('./workout/actions')

fluxxor = {stores: null, actions: null}

fluxxorFactory = (options) ->
  if options? and (!fluxxor.stores or !fluxxor.actions)
    {workouts, workout, _csrf} = options
    stores = { WorkoutStore: new WorkoutStore(options) }
    actions = workoutActions(_csrf)

    fluxxor = new Fluxxor.Flux(stores, actions)

  fluxxor

fluxxorFactory.fluxxor = fluxxor

module.exports = fluxxorFactory
