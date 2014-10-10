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
    @title = ko.observable(data.title)
    @type = ko.observable(data.type)
    @weight = ko.observable(data.weight)
    @due_date = ko.observable(data.due_date)
    @parts = ko.observableArray(data.parts)
    @multiple = (@parts().length > 1);

class AssignementPart

  constructor: (data) ->
    @due_date = ko.observable(data.due_date)
    @weight = ko.observable(data.weight)
    @title = ko.observable(data.title)


DemoAssignements = ->
  a = [
    new Assignement(
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
    new Assignement(
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
    new Assignement(
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
    new Assignement(
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
GradeBookViewModel = ->
  self = this
  self.assignements = ko.observableArray(DemoAssignements())
  self.students = ko.observableArray(DemoStundents(self.assignements()))
  self.breakpoint = ->
    console.log "breaking point"
    return

  return
ko.applyBindings new GradeBookViewModel()
