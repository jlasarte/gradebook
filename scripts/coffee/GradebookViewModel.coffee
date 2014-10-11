DemoAssignements = ->
  a = [
    new Assignement().initialize_data(
      title: "TP1"
      type: "Trabajo Practico"
      weight: "50"
      parts: [
        new AssignementPart().initialize_data(
          title: "Preguntas"
          weight: "50"
          due_date: "12/09"
        )
        new AssignementPart().initialize_data(
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
        new AssignementPart().initialize_data(
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
        new AssignementPart().initialize_data(
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
        new AssignementPart().initialize_data(
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
      if @multiple()
        false
      else
        if @parts().length > 0
          @parts()[0].is_selected()
        else
          false
    ,this)

  toAssignmentPart: ->
    part = new AssignementPart()
    part.title(@title())
    part.due_date(@due_date())
    part.weight(@weight())

    part

  initialize_data: (data)->
    
    @title data.title
    @type data.type
    @weight data.weight
    @due_date data.due_date
    @parts data.parts

    # return object for chaining etc
    this

class AssignementPart

  constructor: ->
    @due_date = ko.observable()
    @weight = ko.observable()
    @title = ko.observable()
    @is_selected = ko.observable(false)

  initialize_data: (data) ->
    @due_date(data.due_date)
    @weight(data.weight)
    @title(data.title)
    #return constructor for chaining
    this

  toggle_selection: ->
    @is_selected(!@is_selected())

class GradeBookViewModel

  constructor: ->
    @assignements = ko.observableArray(DemoAssignements())
    @students = ko.observableArray(DemoStundents(@assignements()))
  
  breakpoint: ->
    console.log "breaking point"

  convert_selected_assignments_to_group: ->
    ass = new Assignement()
    ass.title("Grouped")
    for a in @assignements() when a.is_selected()
      ass.parts.push(a.toAssignmentPart())
      @assignements.destroy(a)
    @assignements.push(ass)

ko.applyBindings new GradeBookViewModel()
