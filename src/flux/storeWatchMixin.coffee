Fluxxor = require "fluxxor"
_ = require "underscore"
flux = require "./index"

module.exports = ->

  storeNames = Array::slice.call(arguments)
  storeWatchMixin = Fluxxor.StoreWatchMixin(storeNames)

  if !!storeWatchMixin
    delete storeWatchMixin.componentWillMount

    storeWatchMixin.componentWillUnmount = ->
      _(storeNames).forEach ((storeName) ->
        store = flux().store(storeName)
        store.removeListener "change", @_setStateFromFlux  if store
        return
      ), this
      return

    storeWatchMixin._setStateFromFlux = ->
      @setState @getStateFromFlux()  if @isMounted()
      return

    storeWatchMixin.componentDidMount = ->
      _(storeNames).forEach ((storeName) ->
        store = flux().store(storeName)
        if store
          store.on "change", @_setStateFromFlux
        else
          console.log "Store " + storeName + " could not be found to be watched."
        return
      ), this
      return

    storeWatchMixin.getErrors = ->
      _(flux().stores).chain().map((store) ->
        store.errors
      ).flatten().compact().value()

    storeWatchMixin.getMessages = ->
      _(flux().stores).chain().map((store) ->
        store.messages
      ).flatten().compact().value()

  storeWatchMixin
