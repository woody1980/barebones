namespace("AppSkeleton.Person.Order")

class AppSkeleton.Person.Order.View extends Backbone.View

  template: JST["app/scripts/person/order/template.ejs"]

  initialize: (options) ->
    @model = options.model

  render: ->
    @$el.html(@template())
    @setFields()
    @

  setFields: ->
    if @model
      @$("[data-id=subTotal]").html(@model.subTotal())
