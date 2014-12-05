promiseStub = {}

promiseStub.then = (funcToCall) ->
  funcToCall()
  promiseStub

promiseStub.error = (funcToCall) ->
  funcToCall()
  promiseStub

promiseStub.catch = (funcToCall) ->
  funcToCall()
  promiseStub

promiseStub.done = (funcToCall) ->
  funcToCall()
  promiseStub

module.exports = promiseStub
