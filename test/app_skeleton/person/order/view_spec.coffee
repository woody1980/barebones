describe "Person.Order.View", ->

  buildView = (model = buildModel()) ->
    new AppSkeleton.Person.Order.View
      model: model

  buildModel = ->
    new AppSkeleton.Person.Order.Model
      subTotal: "35.00"
      tax: "2.50"
      total: "37.50"

  it "has a subTotal field", ->
    view = buildView()

    view.render()

    expect(view.$("[data-id=subTotal]")).toExist()

  it "initializes the inputs using data from the order model", ->
    view = buildView()

    view.render()

    expect(view.$("[data-id=subTotal]").html()).toBe("35.00")
