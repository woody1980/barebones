namespace("Fakes")

class Fakes.App

  constructor: (options) ->
    SP.Application.setContainer(options.container)
    @router = options.router

  @build: ->
    authenticator = new Fakes.Authenticator(loggedIn: true)
    spyOn(SP, "Authenticator").andReturn(authenticator)

    fixtures = setFixtures('<div data-id="some-container"></div>')
    container = fixtures.find("[data-id=some-container]")

    new Fakes.App
      container: container
      router: new SP.Router(appContainer: container)

  find: (selector) ->
    SP.Application.container().find(selector)
