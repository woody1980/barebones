describe "Person.Order.Model", ->

  buildOrder = (orderData) ->
    new AppSkeleton.Person.Order.Model orderData

  buildOrderData = ->
    subTotal: 35.00
    tax: 2.50

  describe "The Order Model", ->

    it "sets the fields", ->
      orderData = buildOrderData()

      order = buildOrder(orderData)

      expect(order.attributes).toEqual(buildOrderData())

    it "has functions to get the fields", ->
      orderData = buildOrderData()

      order = buildOrder(orderData)

      expect(order.subTotal()).toEqual(orderData.subTotal)
      expect(order.tax()).toEqual(orderData.tax)
      expect(order.total()).toEqual(orderData.subTotal + orderData.tax)

  describe "The Order Collection", ->

    it "can have an order added to it", ->
      collection = new AppSkeleton.Person.Order.Collection()
      order = buildOrder()
      collection.add(order)

      expect(collection.first()).toBe(order)

    it "can have multiple orders", ->
      collection = new AppSkeleton.Person.Order.Collection()
      collection.add([buildOrder(), buildOrder(), buildOrder()])

      expect(collection.length).toBe(3)
