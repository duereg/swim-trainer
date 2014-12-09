{expect, sinon} = require 'spec/spec-helper'

Store = require 'src/flux/workout/store'
constants = require 'src/flux/workout/constants'

describe 'flux/workout/store', ->
  {store, emitStub} = {}

  describe 'created with options', ->
    {workout} = {}

    beforeEach ->
      workout = {_id: 4566}
      store = new Store({workout})

    it 'sets errors to an array', ->
      expect(store.errors).to.eql([])

    it 'sets messages to an array', ->
      expect(store.messages).to.eql([])

    it 'sets workout correctly', ->
      expect(store.workout._id).to.eq(workout._id)

    it 'populates a formatted Workout object', ->
      expect(store.workout.formatted).to.be.ok

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

    it 'sets workout to an object', ->
      expect(store.workout).to.be.ok

    it 'populates a formatted Workout object', ->
      expect(store.workout.formatted).to.be.ok

    describe 'onWorkoutDeleteSuccess', ->
      {workoutToDelete} = {}

      beforeEach ->
        workoutToDelete = {_id: 3}
        store.workouts.push {_id: 1}, {_id: 2}, workoutToDelete
        store.onWorkoutDeleteSuccess workout: workoutToDelete

      it 'removes an existing workout from the workout collection', ->
        expect(store.workouts).not.to.contain workoutToDelete

      it 'contains the other workouts', ->
        expect(store.workouts.length).to.eq 2

    describe 'onWorkoutUpdateSuccess', ->
      {updatedWorkout, workoutBeingUpdated} = {}

      beforeEach ->
        workoutBeingUpdated = {_id: 3}
        updatedWorkout = {_id: 3, stuff: 'new', raw: '4x100 huho @ 1:30'}
        store.workouts.push {_id: 1}, {_id: 2}, workoutBeingUpdated
        store.onWorkoutUpdateSuccess workout: updatedWorkout

      it 'adds the updated workout to the workout collection', ->
        expect(store.workouts).to.contain updatedWorkout

      it 'removes the existing workout from the workout collection', ->
        expect(store.workouts).not.to.contain workoutBeingUpdated

    # describe 'onWorkoutAddIntervalSuccess', ->

    describe 'onWorkoutSaveSuccess', ->
      {workout, payload} = {}

      beforeEach ->
        workout = {_id: 4, raw: '4x100 huho @ 1:30'}
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

      it 'maps constants.ADD_INTERVAL_SUCCESS to onWorkoutAddIntervalSuccess', ->
        expect(store.__actions__[constants.ADD_INTERVAL_SUCCESS])
          .to.eq(store.onWorkoutAddIntervalSuccess)

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
