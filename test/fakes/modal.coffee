namespace "Fakes"
class Fakes.Modal

  constructor: (options) ->
    @options = options
    @showCalled = false
    @hideCalled = false

  show: ->
    @showCalled = true

  hide: ->
    @hideCalled = true
