Fluxxor = require('fluxxor')

WorkoutStore = require('./stores/workout/store')
workoutActions = require('./actions/workout/actions')

fluxxor = {stores: null, actions: null}

fluxxorFactory = ({workouts, csrf}) ->
  if (!fluxxor.stores || !fluxxor.actions)
    stores = WorkoutStore: new WorkoutStore(workouts)
    actions = workoutActions(csrf)

    fluxxor = new Fluxxor.Flux(stores, actions)
  fluxxor

fluxxorFactory.fluxxor = fluxxor

module.exports = fluxxorFactory
