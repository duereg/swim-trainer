constants = require('./constants')
workoutData = require('../../data/workout')

csrf = null

actions =
  delete: (workout) ->
    me = this
    me.dispatch(constants.DELETE)

    workoutData
      .delete(workout._id, _csrf)
      .then( ->
        me.dispatch(constants.DELETE_SUCCESS, {workout: workout})
      )
      .error( ->
        me.dispatch(constants.DELETE_FAILURE, {error: er, workout: workout})
      )
  save: (date, workout) ->
    me = this
    me.dispatch(constants.SAVE)

    if workout._id
      workoutData
        .update(date, workout, csrf)
        .then( ->
          me.dispatch(constants.UPDATE_SUCCESS, {workout: workout})
        )
        .error( (er) ->
          me.dispatch(constants.UPDATE_FAILURE, {error: er, workout: workout})
        )
    else
      workoutData
        .create(date, workout, csrf)
        .then( ->
          me.dispatch(constants.CREATE_SUCCESS, {workout: workout})
        )
        .error( (er) ->
          me.dispatch(constants.CREATE_FAILURE, {error: er, workout: workout})
        )

module.exports = (csrf) ->
  throw new Error('Invalid CSRF given') unless csrf?

  csrf = csrf
  actions
