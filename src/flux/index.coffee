Fluxxor = require('fluxxor')

WorkoutStore = require('./workout/store')
workoutActions = require('./workout/actions')

fluxxor = {stores: null, actions: null}

fluxxorFactory = (options) ->
  console.log "in ff"

  if options? and (!fluxxor.stores or !fluxxor.actions)
    {workouts, workout, _csrf} = options
    stores = { WorkoutStore: new WorkoutStore(workouts, workout) }
    actions = workoutActions(_csrf)

    fluxxor = new Fluxxor.Flux(stores, actions)
  else
    console.log 'no options'

  fluxxor

fluxxorFactory.fluxxor = fluxxor

module.exports = fluxxorFactory
