class Student
  constructor: (data) ->
    @id = ko.observable(data.id)
    @name = ko.observable(data.name)
    @lastname = ko.observable(data.lastname)
    @comments = ko.observable(data.comments)
    @grades = ko.observableArray([])

    @final_grade = ko.computed(->
      10
    ,this)

  initialize_grades: (assignments) ->
    for assignment in assignments
      for part in assignment.parts()
        @grades.push new Grade(part)
    #return object for chaining
    this

class Grade
  
  constructor: (assignment) ->
    @grade = ko.observable()
    @text_grade = ko.observable()
    @assignment = assignment
    @wieghted_grade = ko.computed(->
      10
    ,this)

class Assignement 
  
  constructor: (data) ->
    
    @title = ko.observable()
    @type = ko.observable()
    @weight = ko.observable()
    @due_date = ko.observable()
    @parts = ko.observableArray()

    @multiple = ko.computed(->
      @parts().length > 1
    ,this);

    @is_selected = ko.computed(->
      if @multiple
        false
      else
        if @parts().length > 0
          @parts()[0].is_selected()
        else
          false
    ,this)

  initialize_data: (data)->
    
    @title data.title
    @type data.type
    @weight data.weight
    @due_date data.due_date
    @parts data.parts

    # return object for chaining etc
    this

class AssignementPart

  constructor: (data) ->
    @due_date = ko.observable(data.due_date)
    @weight = ko.observable(data.weight)
    @title = ko.observable(data.title)
    @is_selected = ko.observable(false)

  toggle_selection: ->
    @is_selected(!@is_selected())


DemoAssignements = ->
  a = [
    new Assignement().initialize_data(
      title: "TP1"
      type: "Trabajo Practico"
      weight: "50"
      parts: [
        new AssignementPart(
          title: "Preguntas"
          weight: "50"
          due_date: "12/09"
        )
        new AssignementPart(
          title: "Participacion"
          type: "Part"
          weight: "50"
          due_date: "20/09"
        )
      ]
    )
    new Assignement().initialize_data(
      title: "TP5"
      type: "Trabajo Practico"
      weight: "10"
      due_date: "30/6",
      parts: [
        new AssignementPart(
          title: ""
          weight: "100"
          due_date: "12/09"
        )
      ]
    )
    new Assignement().initialize_data(
      title: "TP3"
      type: "Trabajo Practico"
      weight: "10"
      due_date: "30/6",
      parts: [
        new AssignementPart(
          title: ""
          weight: "100"
          due_date: "12/09"
        )
      ]
    )
    new Assignement().initialize_data(
      title: "TP3"
      type: "Trabajo Practico"
      weight: "10"
      due_date: "30/6",
      parts: [
        new AssignementPart(
          title: ""
          weight: "100"
          due_date: "12/09"
        )
      ]
    )
  ]
  a
DemoStundents = (a) ->
  s = [
    new Student(
      id: 12223
      name: "Julia"
      lastname: "Lasarte"
      comments: "Un comentario"
    ).initialize_grades(a)
    new Student(
      id: 465416
      name: "Juan"
      lastname: "Lasarte"
      comments: ""
    ).initialize_grades(a)
    new Student(
      id: 45646
      name: "Pedro"
      lastname: "Lasarte"
      comments: ""
    ).initialize_grades(a)
    new Student(
      id: 13213
      name: "Maria"
      lastname: "Lasarte"
      comments: ""
    ).initialize_grades(a)
    new Student(
      id: 45646
      name: "Elena"
      lastname: "Lasarte"
      comments: "Un comentario"
    ).initialize_grades(a)
    new Student(
      id: 79878
      name: "Pedro"
      lastname: "Lasarte"
      comments: "Un comentario"
    ).initialize_grades(a)
  ]
  s

class GradeBookViewModel
  constructor: ->
    @assignements = ko.observableArray(DemoAssignements())
    @students = ko.observableArray(DemoStundents(@assignements()))
  
  breakpoint: ->
    console.log "breaking point"

  convert_selected_assignments_to_group: ->
    assignment = new Assignement()
    console.log a for a in @assignements() when a.is_selected()

ko.applyBindings new GradeBookViewModel()
