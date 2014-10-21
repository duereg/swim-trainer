Fluxxor = require('fluxxor')

WorkoutStore = require('./stores/workout/store')
workoutActions = require('./actions/workout/actions')

fluxxor = {stores: null, actions: null}

fluxxorFactory = (workouts) ->
  if (!fluxxor.stores || !fluxxor.actions)
    stores = WorkoutStore: new WorkoutStore(account)
    actions = workoutActions

    fluxxor = new Fluxxor.Flux(stores, actions)
  fluxxor

fluxxorFactory.fluxxor = fluxxor

module.exports = fluxxorFactory
