namespace('AppSkeleton')

class AppSkeleton.Router extends Backbone.Router

  routes:
    "": "default"

  initialize: (options) ->
    @container = options.appContainer

  default: ->
    view = new AppSkeleton.Person.View().render()
    @container.append(view.$el)
