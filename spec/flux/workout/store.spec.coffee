{expect, sinon} = require 'spec/spec-helper'

Store = require 'src/flux/workout/store'
constants = require 'src/flux/workout/constants'

describe 'flux/workout/store', ->
  {store, emitStub} = {}

  describe 'created with options', ->
    {workout} = {}

    beforeEach ->
      workout = {id: 4566}
      store = new Store({workout})

    it 'sets errors to an array', ->
      expect(store.errors).to.eql([])

    it 'sets messages to an array', ->
      expect(store.messages).to.eql([])

    it 'sets workout correctly', ->
      expect(store.workout.id).to.eq(workout.id)

  describe 'created with no options', ->
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
      {workout, payload} = {}

      beforeEach ->
        workout = {id: 4, raw: '4x100 huho @ 1:30'}
        payload = {workout}
        store.workout = workout
        store.onWorkoutSaveSuccess(payload)

      it 'store.workouts now contains the workout', ->
        expect(store.workouts).to.contain(workout)

    describe 'onError', ->
      error = 'foo bar me!'
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
      it 'maps constants.SAVE to onLoad', ->
        expect(store.__actions__[constants.SAVE]).to.eq(store.onLoad)

      it 'maps constants.CREATE_SUCCESS to onWorkoutSaveSuccess', ->
        expect(store.__actions__[constants.CREATE_SUCCESS]).to.eq(store.onWorkoutSaveSuccess)

      it 'maps constants.CREATE_FAILURE to onError', ->
        expect(store.__actions__[constants.CREATE_FAILURE]).to.eq(store.onError)

      it 'maps constants.UPDATE_SUCCESS to onWorkoutUpdateSuccess', ->
        expect(store.__actions__[constants.UPDATE_SUCCESS]).to.eq(store.onWorkoutUpdateSuccess)

      it 'maps constants.UPDATE_FAILURE to onError', ->
        expect(store.__actions__[constants.UPDATE_FAILURE]).to.eq(store.onError)

      it 'maps constants.DELETE to onLoad', ->
        expect(store.__actions__[constants.DELETE]).to.eq(store.onLoad)

      it 'maps constants.DELETE_SUCCESS to onWorkoutDeleteSuccess', ->
        expect(store.__actions__[constants.DELETE_SUCCESS]).to.eq(store.onWorkoutDeleteSuccess)

      it 'maps constants.DELETE_FAILURE to onError', ->
        expect(store.__actions__[constants.DELETE_FAILURE]).to.eq(store.onError)
