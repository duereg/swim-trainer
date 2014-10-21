Fluxxor = require('fluxxor')

WorkoutStore = require('./workout/store')
workoutActions = require('./workout/actions')

fluxxor = {stores: null, actions: null}

fluxxorFactory = ({workouts, _csrf}) ->
  if (!fluxxor.stores || !fluxxor.actions)
    stores = WorkoutStore: new WorkoutStore(workouts)
    actions = workoutActions(_csrf)

    fluxxor = new Fluxxor.Flux(stores, actions)
  fluxxor

fluxxorFactory.fluxxor = fluxxor

module.exports = fluxxorFactory
