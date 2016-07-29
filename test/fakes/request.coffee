namespace("Fakes")

class Fakes.Request

  constructor: ->
    @_wasExecuted = false

  execute: (onSuccess, onError) ->
    @_wasExecuted = true
    @givenOnSuccess = onSuccess
    @givenOnError = onError

  wasExecuted: ->
    @_wasExecuted
