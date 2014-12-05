require 'songbird'
promiseStub = require './promiseStub'

chai = require 'chai'
faker = require 'faker'
should = chai.should()

module.exports = {expect: chai.expect, chai, should, faker, promiseStub}
