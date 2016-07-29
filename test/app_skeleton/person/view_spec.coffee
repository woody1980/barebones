describe "Person.View", ->

  buildView = (model = buildModel()) ->
    new AppSkeleton.Person.View
      model: model

  buildModel = ->
    new AppSkeleton.Person.Model
      name: "John"
      birthDate: new Date()

  it "has the 'name' field", ->
    view = buildView()

    view.render()

    expect(view.$("[data-id=name]")).toExist()

  it "has the 'birth date' field", ->
    view = buildView()

    view.render()

    expect(view.$("[data-id=birth-date]")).toExist()

  it "initializes the inputs using data from the person model", ->
    person = buildModel()
    view = buildView(person)

    view.render()

    expect(view.$("[data-id=name]").val()).toBe(person.name())
    expect(view.$("[data-id=birth-date]").val()).toBe(person.birthDate().toString())
