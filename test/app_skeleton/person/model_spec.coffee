describe "Person.Model", ->

  buildPerson = (personData)->
    person = new AppSkeleton.Person.Model personData

  buildPersonData = (birthDate) ->
    name:"John"
    birthDate: birthDate
    orders: [
      {subTotal: "35.00", tax:"2.50", total:"37.50"}
      {subTotal: "5.00", tax:".50", total:"5.50"}
    ]

  describe "The Person's Fields", ->

    it "sets the fields", ->
      personData = buildPersonData(new Date())

      person = buildPerson(personData)

      expect(person.attributes).toEqual(personData)

    it "has functions to get the fields", ->
      date = new Date()
      personData = buildPersonData(date)

      person = buildPerson(personData)

      expect(person.name()).toBe("John")
      expect(person.birthDate()).toBe(date)

  describe "The Person's Orders", ->

    it "has a collection of orders", ->
      personData = buildPersonData(new Date())

      person = buildPerson(personData)

      expect(person.orders().length).toBe(2)
