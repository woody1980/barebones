namespace('Barebones')

class Barebones.Router extends Backbone.Router

  routes:
    "": "default"

  initialize: (options) ->
    @container = options.appContainer

  default: ->
    view = new Barebones.Person.View().render()
    @container.append(view.$el)
