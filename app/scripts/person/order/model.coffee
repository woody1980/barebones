namespace "AppSkeleton.Person.Order"

class AppSkeleton.Person.Order.Model extends Backbone.Model

  subTotal: ->
    @get "subTotal"

  tax: ->
    @get "tax"

  total: ->
    @tax() + @subTotal()

class AppSkeleton.Person.Order.Collection extends Backbone.Collection

  model: AppSkeleton.Person.Order.Model
