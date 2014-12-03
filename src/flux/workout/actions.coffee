constants = require('./constants')
workoutData = require('../../data/workout')

csrf = null

actions =
  workout:
    save: (date, workout) ->
      @dispatch(constants.SAVE)

      if workout._id
        workoutData.update(date, workout, csrf)
      else
        workoutData.save(date, workout, csrf)

      #TODO: run action to save, then dispatch results
      # wishlistData
      #   .remove(wishlistId)
      #   .then(function(){
      #     this.dispatch(constants.SAVE_SUCCESS, {wishlist: wishlist, item: item});
      #   }.bind(this))
      #   .error(function(er) {
      #     this.dispatch(constants.SAVE_FAILURE, {error: er, wishlist: wishlist, item: item});
      #   }.bind(this));

module.exports = (csrf) ->
  throw new Error('Invalid CSRF given') unless csrf?

  csrf = csrf
  actions
