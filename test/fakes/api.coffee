namespace("Fakes")

class Fakes.Api

  constructor: ->
    @fakeServer = sinon.fakeServer.create()

  lastRequest: ->
    _.last(@fakeServer.requests)

  requestCount: ->
    @fakeServer.requests.length

  respondAll: ->
    if @fakeServer.queue
      while @fakeServer.queue.length > 0
        @fakeServer.respond()

  stubSomeEndpoint: (batchId, response) ->
    @fakeServer.respondWith(
      "POST",
      SP.Endpoints.SomeEndpoint(option: "optionValue"),
      @successfulResponse(response)
    )

  successfulResponse: (response) ->
    [200, {"Content-Type":"application/json"}, JSON.stringify(response)]
