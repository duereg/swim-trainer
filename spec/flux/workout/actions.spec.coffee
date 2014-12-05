{expect, sinon, promiseStub} = require 'spec/spec-helper'

workoutData = require 'src/data/workout'
constants = require 'src/flux/workout/constants'
actions = require('src/flux/workout/actions')('fake_csrf_token')


describe 'flux/workout/actions', ->
  beforeEach ->
    actions.dispatch = sinon.spy

  afterEach ->
    delete actions.dispatch

  describe '#save', ->
    {workout} = {}

    describe 'with id', ->
      {saveStub} = {}

      beforeEach ->
        saveStub = sinon.stub(workoutData, 'save').returns(promiseStub)
        workout = {_id: 123}
        actions.save "2014-01-01", workout

      it 'calls dispatch to indicate save process is started', ->
        expect(actions.dispatch.calledWith constants.SAVE).to.be.true

      it 'calls dispatch to indicate save process finished', ->
        expect(actions.dispatch.calledWith(constants.SAVE_SUCCESS)).to.be.true

      it 'calls dispatch to indicate save process errored', ->
        expect(actions.dispatch.calledWith(constants.SAVE_SUCCESS)).to.be.true

      it 'calls dispatch with the selected items', ->
        expect(saveStub.calledWith("2014-01-01", workout)).to.be.true

    describe 'without id', ->
      {updateStub} = {}

      beforeEach ->
        updateStub = sinon.stub(workoutData, 'update').returns(promiseStub)
        workout = {}
        actions.save "2014-01-01", workout

      it 'calls dispatch to indicate save process is started', ->
        expect(actions.dispatch.calledWith constants.SAVE).to.be.true

      it 'calls dispatch to indicate update process finished', ->
        expect(actions.dispatch.calledWith(constants.UPDATE_SUCCESS)).to.be.true

      it 'calls dispatch to indicate update process errored', ->
        expect(actions.dispatch.calledWith(constants.UPDATE_SUCCESS)).to.be.true

      it 'calls dispatch with the selected items', ->
        expect(updateStub.calledWith("2014-01-01", workout)).to.be.true
