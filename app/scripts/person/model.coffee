namespace "AppSkeleton.Person"

class AppSkeleton.Person.Model extends Backbone.Model

  name: ->
    @get "name"

  birthDate: ->
    @get "birthDate"

  orders: ->
    @get "orders"
