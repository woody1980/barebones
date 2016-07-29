namespace("AppSkeleton.Person")

class AppSkeleton.Person.View extends Backbone.View

  template: JST["app/scripts/person/template.ejs"]

  initialize: (options) ->
    @model = options?.model

  render: ->
    @$el.html(@template())
    @setFields()
    @

  setFields: ->
    if @model
      @$("[data-id=name]").val(@model.name())
      @$("[data-id=birth-date]").val(@model.birthDate().toString())
