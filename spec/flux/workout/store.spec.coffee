{expect, sinon} = require 'spec/spec-helper'

Store = require 'src/flux/workout/store'
constants = require 'src/flux/workout/constants'

describe 'flux/workout/store', ->
  {store, emitStub} = {}

  describe "created with options", ->
    {workout} = {}

    beforeEach ->
      workout = {id: 4566}
      store = new Store(workout)

    it 'sets errors to an array', ->
      expect(store.errors).to.eql([])

    it 'sets messages to an array', ->
      expect(store.messages).to.eql([])

    it 'sets workout correctly', ->
      expect(store.workout.id).to.eq(workout.id)

  describe "created with no options", ->
    beforeEach ->
      store = new Store()
      emitStub = sinon.stub(store, 'emit')

    afterEach ->
      emitStub.restore()

    it 'sets errors to an array', ->
      expect(store.errors).to.eql([])

    it 'sets messages to an array', ->
      expect(store.messages).to.eql([])

    it 'sets workout to an empty object', ->
      expect(store.workout).to.eql({})

    describe 'onWorkoutSaveSuccess', ->
      item = {id: 321}
      wishlist = {id: 4, isPublic: false, wishlistItems: [item]}
      payload = {wishlist: wishlist}

      beforeEach ->
        store.wishlist = wishlist
        store.onWorkoutSaveSuccess(payload)

      it 'emit "change") is called', ->
        expect(emitStub.called).to.be.true

    describe 'onError', ->
      error = "foo bar me!"
      beforeEach ->
        store.onError error: error

      it 'the error is set to the given error', ->
        expect(store.errors).to.contain(error)

      it 'emit("change") is called', ->
        expect(emitStub.called).to.be.true

      describe 'onLoad', ->
        beforeEach ->
          store.onLoad()

        it 'the error state is reset', ->
          expect(store.errors).to.eql([])

        it 'the message state is reset', ->
          expect(store.messages).to.eql([])

        it 'emit("change") is called', ->
          expect(emitStub.called).to.be.true

    describe 'actions hash', ->
      it "maps constants.SAVE to onLoad", ->
        expect(store.__actions__[constants.SAVE]).to.eq(store.onLoad)

      it "maps constants.SAVE_SUCCESS to onWorkoutSaveSuccess", ->
        expect(store.__actions__[constants.SAVE_SUCCESS]).to.eq(store.onWorkoutSaveSuccess)

      it "maps constants.SAVE_FAILURE to onError", ->
        expect(store.__actions__[constants.SAVE_FAILURE]).to.eq(store.onError)

      it "maps constants.DELETE to onLoad", ->
        expect(store.__actions__[constants.DELETE]).to.eq(store.onLoad)

      it "maps constants.DELETE_SUCCESS to onWorkoutDeleteSuccess", ->
        expect(store.__actions__[constants.DELETE_SUCCESS]).to.eq(store.onWorkoutDeleteSuccess)

      it "maps constants.DELETE_FAILURE to onError", ->
        expect(store.__actions__[constants.DELETE_FAILURE]).to.eq(store.onError)
