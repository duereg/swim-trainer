_ = require('underscore')
Fluxxor = require('fluxxor')

constants = require('./constants')

workoutStore = Fluxxor.createStore
  initialize: (options) ->
    {workouts, workout, csrf} = options if options?

    @errors = []
    @messages = []
    @workouts = if workouts?.length then workouts else []
    @workout = if workout? then workout else {}

    @bindActions(
      constants.SAVE, @onLoad,
      constants.SAVE_SUCCESS, @onWorkoutSaveSuccess,
      constants.SAVE_FAILURE, @onError
    )

  sortedWorkouts: ->
    _(@workouts).sortBy (workout) -> workout.date

  onLoad: ->
    @errors = []
    @messages = []
    @emit('change')

  onError: (payload) ->
    @messages = []
    @errors = [(payload.error && payload.error.error) || payload.error || payload.toString()]
    @emit('change')

  onWorkoutSaveSuccess: (payload) ->
    #TODO: make sure save does something
    # @workouts.push(payload.workout)
    @emit('change')

module.exports = workoutStore
