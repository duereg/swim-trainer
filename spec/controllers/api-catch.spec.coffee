chai = require('chai')
expect = chai.expect
sinon = require('sinon')

chai.use(require('sinon-chai'))

apiCatch = require('../../controllers/api-catch')

response = {}
response.send = -> response
response.status = -> response

describe 'controllers/wishlists/index - apiCatch', ->
  {sendStub, statusStub, servicePayload, consoleWarnStub} = {}

  beforeEach ->
    consoleWarnStub = sinon.stub(console, 'warn')
    sendStub = sinon.spy(response, 'send')
    statusStub = sinon.spy(response, 'status')
    servicePayload = apiCatch(response)

  afterEach ->
    sendStub.restore()
    statusStub.restore()
    consoleWarnStub.restore()

  describe 'called with no payload', ->
    {returns} = {}

    beforeEach ->
      returns = servicePayload()

    it 'console.warn is called', ->
      expect(consoleWarnStub.called).to.be.true

    it 'returns the response object', ->
      expect(returns).to.eq(response)

  describe 'called with a status code and an error', ->
    {body} = {}

    beforeEach ->
      body = 'Thar be giants!'
      servicePayload statusCode: 4321, error: body

    it 'calls status with the given status code', ->
      expect(statusStub.calledWith(4321)).to.be.true

    it 'calls send with the given body', ->
      expect(sendStub.calledWith(body)).to.be.true

  describe 'called with a status and a detail', ->
    {body, apiError} = {}

    beforeEach ->
      body = 'Thar be giants!'
      apiError = {status: '4321', detail: body}
      servicePayload(apiError)

    it 'calls status with the given status, parsed as an int', ->
      expect(statusStub.calledWith(4321)).to.be.true

    it 'calls send with the given apiError', ->
      expect(sendStub.calledWith(errors: [apiError])).to.be.true

  describe 'called with something valid', ->
    {body} = {}

    beforeEach ->
      body = 'Thar be giants!'
      servicePayload(body)

    it 'calls status with a 500', ->
      expect(statusStub.calledWith(500)).to.be.true

    it 'calls send with the given something', ->
      expect(sendStub.calledWith(errors: [body])).to.be.true
