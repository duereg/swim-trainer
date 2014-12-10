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

    it 'sets workout date', ->
      expect(store.workout.date).to.be.ok

    it 'populates a formatted Workout object', ->
      expect(store.workout.formatted).to.be.ok

    describe 'onWorkoutUpdateDateSuccess', ->
      {workoutToDelete} = {}

      beforeEach ->
        store.onWorkoutUpdateDateSuccess {date: '2010-01-02'}

      it 'updates an existing workout with a new date', ->
        expect(store.workout.date.getFullYear()).to.eq 2010

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

    describe 'onWorkoutAddIntervalSuccess', ->
      {workoutWithInterval} = {}

      beforeEach ->
        store.onWorkoutAddIntervalSuccess {type: 'one', length: '1:30'}
        workoutWithInterval = store.workout.formatted

      it 'creates a set "---SIMPLE WORKOUT---"', ->
        expect(workoutWithInterval.current().name).to.eq '---SIMPLE WORKOUT---'

      it 'adds an interval to the set', ->
        expect(workoutWithInterval.current().intervals.length).to.eq 1

      it 'sets the interval type to "one"', ->
        expect(workoutWithInterval.current().current().type).to.eq 'one'

      it 'sets the interval time to a 1:30 duration', ->
        expect(workoutWithInterval.current().current().time.minutes()).to.eq 1
        expect(workoutWithInterval.current().current().time.seconds()).to.eq 30

      it 'emit("change") is called', ->
        expect(emitStub.called).to.be.true

      describe 'onWorkoutDeleteIntervalSuccess', ->
        beforeEach ->
          store.onWorkoutDeleteIntervalSuccess {interval: workoutWithInterval.current().current()}

        it 'removes the interval from the workout', ->
          expect(workoutWithInterval.current().intervals.length).to.eq 0

        it 'emit("change") is called', ->
          expect(emitStub.called).to.be.true

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

      it 'maps constants.DELETE_INTERVAL_SUCCESS to onWorkoutDeleteIntervalSuccess', ->
        expect(store.__actions__[constants.DELETE_INTERVAL_SUCCESS])
          .to.eq(store.onWorkoutDeleteIntervalSuccess)

      it 'maps constants.UPDATE_DATE_SUCCESS to onWorkoutUpdateDateSuccess', ->
        expect(store.__actions__[constants.UPDATE_DATE_SUCCESS])
          .to.eq(store.onWorkoutUpdateDateSuccess)

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
