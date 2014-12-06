{expect, sinon, promiseStub} = require 'spec/spec-helper'

workoutData = require 'src/data/workout'
constants = require 'src/flux/workout/constants'
actions = require('src/flux/workout/actions')('fake_csrf_token')

describe 'flux/workout/actions', ->
  beforeEach ->
    actions.dispatch = sinon.spy()

  afterEach ->
    delete actions.dispatch

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

    describe 'with id', ->
      {saveStub} = {}

      beforeEach ->
        saveStub = sinon.stub(workoutData, 'update').returns(promiseStub)
        workout = {_id: 123}
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
        workout = {}
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
