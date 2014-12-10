{expect, sinon, promiseStub} = require 'spec/spec-helper'

workoutData = require 'src/data/workout'
constants = require 'src/flux/workout/constants'
actions = require('src/flux/workout/actions')('fake_csrf_token')

describe 'flux/workout/actions', ->
  beforeEach ->
    actions.dispatch = sinon.spy()

  afterEach ->
    delete actions.dispatch

  describe '#addInterval', ->
    beforeEach ->
      actions.addInterval 'type', '1:00'

    it 'calls dispatch to indicate an Interval should be added', ->
      expect(actions.dispatch.calledWith constants.ADD_INTERVAL_SUCCESS).to.be.true

  describe '#deleteInterval', ->
    beforeEach ->
      actions.deleteInterval {foo: 'bar'}

    it 'calls dispatch to indicate an Interval should be added', ->
      expect(actions.dispatch.calledWith constants.DELETE_INTERVAL_SUCCESS).to.be.true

  describe '#updateDate', ->
    beforeEach ->
      actions.updateDate new Date()

    it 'calls dispatch to indicate an Interval should be added', ->
      expect(actions.dispatch.calledWith constants.UPDATE_DATE_SUCCESS).to.be.true

  describe '#delete', ->
    {workout, delStub} = {}

    beforeEach ->
      delStub = sinon.stub(workoutData, 'delete').returns(promiseStub)
      workout = {_id: 123}
      actions.delete workout

    afterEach ->
      delStub.restore()

    it 'calls dispatch to indicate delete process is started', ->
      expect(actions.dispatch.calledWith constants.DELETE).to.be.true

    it 'calls dispatch to indicate delete process finished', ->
      expect(actions.dispatch.calledWith(constants.DELETE_SUCCESS)).to.be.true

    it 'calls dispatch to indicate delete process errored', ->
      expect(actions.dispatch.calledWith(constants.DELETE_SUCCESS)).to.be.true

    it 'calls dispatch with the selected items', ->
      expect(delStub.calledWith(workout)).to.be.true

  describe '#save', ->
    {workout} = {}

    it 'without params it throws', ->
      expect(actions.save).to.throw

    describe 'with id', ->
      beforeEach ->
        workout = {_id: 123}

      describe 'without date', ->
        it 'throws', ->
          expect( -> actions.save workout).to.throw

      describe 'with date', ->
        {saveStub} = {}

        beforeEach ->
          saveStub = sinon.stub(workoutData, 'update').returns(promiseStub)
          workout.date = new Date()
          actions.save workout

        afterEach ->
          saveStub.restore()

        it 'calls dispatch to indicate save process is started', ->
          expect(actions.dispatch.calledWith constants.SAVE).to.be.true

        it 'calls dispatch to indicate update process finished', ->
          expect(actions.dispatch.calledWith(constants.UPDATE_SUCCESS)).to.be.true

        it 'calls dispatch to indicate update process errored', ->
          expect(actions.dispatch.calledWith(constants.UPDATE_SUCCESS)).to.be.true

        it 'calls dispatch with the selected items', ->
          expect(saveStub.calledWith(workout)).to.be.true

    describe 'without id', ->
      {updateStub} = {}

      beforeEach ->
        updateStub = sinon.stub(workoutData, 'create').returns(promiseStub)
        workout = { date: new Date() }
        actions.save workout

      afterEach ->
        updateStub.restore()

      it 'calls dispatch to indicate save process is started', ->
        expect(actions.dispatch.calledWith constants.SAVE).to.be.true

      it 'calls dispatch to indicate create process finished', ->
        expect(actions.dispatch.calledWith(constants.CREATE_SUCCESS)).to.be.true

      it 'calls dispatch to indicate create process errored', ->
        expect(actions.dispatch.calledWith(constants.CREATE_SUCCESS)).to.be.true

      it 'calls dispatch with the selected items', ->
        expect(updateStub.calledWith(workout)).to.be.true
