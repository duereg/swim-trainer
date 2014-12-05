require 'songbird'
promiseStub = require './promiseStub'

sinon = require 'sinon'
chai = require 'chai'
chai.use require 'sinon-chai'
faker = require 'faker'
should = chai.should()

module.exports = {expect: chai.expect, chai, should, sinon, faker, promiseStub}
