_ = require 'underscore'
Fluxxor = require 'fluxxor'
parser = require 'swim-parser'

constants = require './constants'

workoutStore = Fluxxor.createStore
  initialize: (options) ->
    {workouts, workout, csrf} = options if options?

    @errors = []
    @messages = []
    @workouts = if workouts?.length then workouts else []
    @workout = if workout? then workout else {}

    @bindActions(
      constants.SAVE, @onLoad
      constants.DELETE, @onLoad

      constants.CREATE_SUCCESS, @onWorkoutSaveSuccess
      constants.UPDATE_SUCCESS, @onWorkoutUpdateSuccess
      constants.DELETE_SUCCESS, @onWorkoutDeleteSuccess

      constants.CREATE_FAILURE, @onError
      constants.DELETE_FAILURE, @onError
      constants.UPDATE_FAILURE, @onError
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

  onWorkoutDeleteSuccess: (payload) ->
    @workouts = _(@workouts).filter (workout) -> workout._id isnt payload.workout._id
    @emit('change')

  onWorkoutSaveSuccess: (payload) ->
    payload.workout.formatted = parser(payload.workout.raw)
    @workouts.push(payload.workout)
    window.location = '/workouts'

  onWorkoutUpdateSuccess: (payload) ->
    payload.workout.formatted = parser(payload.workout.raw)
    @workouts = _(@workouts).filter (workout) -> workout._id isnt payload.workout._id
    @workouts.push(payload.workout)
    window.location = '/workouts'

module.exports = workoutStore
