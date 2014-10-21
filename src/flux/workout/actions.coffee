constants = require('./constants')

actions =
  workout:
    sendEmail: ->
      @dispatch(constants.SEND_EMAIL);

      #TODO: run action to save, then dispatch results
      # wishlistData
      #   .remove(wishlistId)
      #   .then(function(){
      #     this.dispatch(constants.SEND_EMAIL_SUCCESS, {wishlist: wishlist, item: item});
      #   }.bind(this))
      #   .error(function(er) {
      #     this.dispatch(constants.SEND_EMAIL_FAILURE, {error: er, wishlist: wishlist, item: item});
      #   }.bind(this));

module.exports = actions
