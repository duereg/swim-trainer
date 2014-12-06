constants = require('./constants')
workoutData = require('src/data/workout')

csrf = null

actions =
  delete: (workout) ->
    throw new Error("Invalid workout") unless workout?

    me = this
    me.dispatch(constants.DELETE)

    workoutData
      .delete(workout, csrf)
      .then( ->
        me.dispatch(constants.DELETE_SUCCESS, {workout: workout})
      )
      .error( (er) ->
        me.dispatch(constants.DELETE_FAILURE, {error: er, workout: workout})
      )
  save: (workout) ->
    throw new Error("Invalid workout") unless workout?

    me = this
    me.dispatch(constants.SAVE)

    if workout._id
      workoutData
        .update(workout, csrf)
        .then( ->
          me.dispatch(constants.UPDATE_SUCCESS, {workout: workout})
        )
        .error( (er) ->
          me.dispatch(constants.UPDATE_FAILURE, {error: er, workout: workout})
        )
    else
      workoutData
        .create(workout, csrf)
        .then( ->
          me.dispatch(constants.CREATE_SUCCESS, {workout: workout})
        )
        .error( (er) ->
          me.dispatch(constants.CREATE_FAILURE, {error: er, workout: workout})
        )

module.exports = (myCsrf) ->
  throw new Error('Invalid CSRF given') unless myCsrf?

  csrf = myCsrf
  actions
