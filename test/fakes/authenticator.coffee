namespace("Fakes")

class Fakes.Authenticator

  constructor: (@options={}) ->

  authenticate: (callback) ->
    callback() if @options.loggedIn
