constants = require('./constants')
workoutData = require('src/data/workout')

csrf = null

actions =
  addInterval: (type, length) ->
    @dispatch(constants.ADD_INTERVAL_SUCCESS, {type, length})

  deleteInterval: (interval) ->
    @dispatch(constants.DELETE_INTERVAL_SUCCESS, {interval})

  delete: (workout) ->
    throw new Error('Invalid workout') unless workout?

    me = this
    me.dispatch(constants.DELETE)

    workoutData
      .delete(workout, csrf)
      .then( ->
        me.dispatch(constants.DELETE_SUCCESS, {workout})
      )
      .error( (er) ->
        me.dispatch(constants.DELETE_FAILURE, {error: er, workout})
      )

  save: (workout) ->
    throw new Error('Invalid workout') unless workout?

    me = this
    me.dispatch(constants.SAVE)

    if workout._id
      workoutData
        .update(workout, csrf)
        .then( ->
          me.dispatch(constants.UPDATE_SUCCESS, {workout})
        )
        .error( (er) ->
          me.dispatch(constants.UPDATE_FAILURE, {error: er, workout})
        )
    else
      workoutData
        .create(workout, csrf)
        .then( ->
          me.dispatch(constants.CREATE_SUCCESS, {workout})
        )
        .error( (er) ->
          me.dispatch(constants.CREATE_FAILURE, {error: er, workout})
        )

module.exports = (myCsrf) ->
  throw new Error('Invalid CSRF given') unless myCsrf?

  csrf = myCsrf
  actions
