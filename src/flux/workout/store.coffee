_ = require('underscore')
Fluxxor = require('fluxxor')

constants = require('./constants')
navigator = require('../navigator')

workoutStore = Fluxxor.createStore
  initialize: (workouts) ->
    this.errors = []
    this.messages = []
    this.workouts = if workouts.length then workouts else []

    this.bindActions
      constants.SAVE, this.onLoad,
      constants.SAVE_SUCCESS, this.onWorkoutSaveSuccess,
      constants.SAVE_FAILURE, this.onError

  sortedWorkouts: () ->
    _(this.workouts).sortBy (workout) -> workout.date

  onLoad: () ->
    this.errors = []
    this.messages = []
    this.emit("change")

  onError: (payload) ->
    this.messages = []
    this.errors = [(payload.error && payload.error.error) || payload.error || payload.toString()]
    this.emit("change")

  onWorkoutSaveSuccess: (payload) ->
    #TODO: make sure save does something
    # this.workouts.push(payload.workout)
    this.emit("change")

module.exports = workoutStore
