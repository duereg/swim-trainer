_ = require 'underscore'
Fluxxor = require 'fluxxor'
parser = require 'swim-parser'
Workout = require 'swim-parser/lib/workout'

constants = require './constants'

workoutStore = Fluxxor.createStore
  initialize: (options) ->
    {workouts, workout, csrf} = options if options?

    @errors = []
    @messages = []
    @workouts = if workouts?.length then workouts else []
    @workout = if workout? then workout else { date: new Date()}

    @workout.formatted ?= new Workout()

    @bindActions(
      constants.SAVE, @onLoad
      constants.DELETE, @onLoad

      constants.ADD_INTERVAL_SUCCESS, @onWorkoutAddIntervalSuccess
      constants.DELETE_INTERVAL_SUCCESS, @onWorkoutDeleteIntervalSuccess
      constants.UPDATE_DATE_SUCCESS, @onWorkoutUpdateDateSuccess
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

  onWorkoutUpdateDateSuccess: ({date}) ->
    console.log 'store: update date', date
    @workout.date = new Date(date)
    @emit('change')

  onWorkoutDeleteIntervalSuccess: ({interval}) ->
    filteredIntervals = _(@workout.formatted.current().intervals).filter (currentInterval) ->
      currentInterval isnt interval

    @workout.formatted.current().intervals.length = 0
    filteredIntervals.forEach @workout.formatted.current().intervals.push
    @emit('change')

  onWorkoutAddIntervalSuccess: ({type, length}) ->
    if @workout.formatted.sets.length is 0
      @workout.formatted.addSet('---SIMPLE WORKOUT---')
    @workout.formatted.current().addInterval()
    @workout.formatted.current().setType type
    @workout.formatted.current().setTime length
    @emit('change')

  onWorkoutDeleteSuccess: (payload) ->
    @workouts = _(@workouts).filter (workout) -> workout._id isnt payload.workout._id
    @emit('change')

  onWorkoutSaveSuccess: (payload) ->
    payload.workout.formatted ?= parser(payload.workout.raw)
    @workouts.push(payload.workout)
    global.location = '/workouts'

  onWorkoutUpdateSuccess: (payload) ->
    throw new Error('Must provide a raw workout to parse') unless payload.workout?.raw?
    payload.workout.formatted ?= parser(payload.workout.raw)
    @workouts = _(@workouts).filter (workout) -> workout._id isnt payload.workout._id
    @workouts.push(payload.workout)
    global.location = '/workouts'

module.exports = workoutStore
