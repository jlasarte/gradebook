DemoAssignements = ->
  a = [
    new Assignement().initialize_data(
      title: "TP1"
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
      title: "TP2"
      type: "Trabajo Practico"
      weight: "50"
      parts: [
        new AssignementPart().initialize_data(
          title: "Argumentacion"
          weight: "80"
          due_date: "12/09"
        )
        new AssignementPart().initialize_data(
          title: "Debate"
          weight: "20"
          due_date: "20/09"
        )
      ]
    )
    new Assignement().initialize_data(
      title: "TP3"
      type: "Trabajo Practico"
      weight: "50"
      parts: [
        new AssignementPart().initialize_data(
          title: "Resumen"
          weight: "10"
          due_date: "12/09"
        )
        new AssignementPart().initialize_data(
          title: "Analisis Pagina"
          weight: "10"
          due_date: "12/09"
        )
        new AssignementPart().initialize_data(
          title: "Resumen"
          weight: "20"
          due_date: "12/09"
        )
        new AssignementPart().initialize_data(
          title: "Informe"
          weight: "60"
          due_date: "20/09"
        )
      ]
    )
    new Assignement().initialize_data(
      title: "TP4 - Divulgacion"
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
      title: "TP5"
      type: "Trabajo Practico"
      weight: "50"
      parts: [
        new AssignementPart().initialize_data(
          title: "Proyecto"
          weight: "10"
          due_date: "12/09"
        )
        new AssignementPart().initialize_data(
          title: "CV"
          weight: "10"
          due_date: "12/09"
        )
        new AssignementPart().initialize_data(
          title: "Presentacion"
          weight: "20"
          due_date: "12/09"
        )
        new AssignementPart().initialize_data(
          title: "Afiche y Folleto"
          weight: "60"
          due_date: "20/09"
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
      lastname: "Perez"
      comments: ""
    ).initialize_grades(a)
    new Student(
      id: 45646
      name: "Pedro"
      lastname: "Alcaucil"
      comments: ""
    ).initialize_grades(a)
    new Student(
      id: 13213
      name: "Maria"
      lastname: "Brucelli"
      comments: ""
    ).initialize_grades(a)
    new Student(
      id: 45646
      name: "Elena"
      lastname: "Ashifu"
      comments: "Un comentario"
    ).initialize_grades(a)
    new Student(
      id: 79878
      name: "Pedro"
      lastname: "Soriano"
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
    @dropedout = ko.observable(false)
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

  comparte_id_to: (another) ->
    switch
      when @id() == another.id() then 0
      when @id() > another.id() then 1
      else -1

  comparte_lastname_to: (another) ->
    switch
      when @lastname() == another.lastname() then 0
      when @lastname() > another.lastname() then 1
      else -1

  comparte_name_to: (another) ->
    switch
      when @name() == another.name() then 0
      when @name() > another.name() then 1
      else -1

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
    
    @is_selected = ko.observable(false)

    @multiple = ko.computed(->
      @parts().length > 1
    ,this);

  toggle_selection: ->
    @is_selected(!@is_selected())
  
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

  ungroup:(parent)->
    parent.ungroup this

class AssignementPart

  constructor: ->
    @due_date = ko.observable()
    @weight = ko.observable()
    @title = ko.observable()

  initialize_data: (data) ->
    @due_date(data.due_date)
    @weight(data.weight)
    @title(data.title)
    #return constructor for chaining
    this

  to_assignment: ->
    assignment = new Assignement()
    assignment.title(@title())
    assignment.due_date(@due_date())
    assignment.weight(@weight())
    assignment.parts.push(this)
    return assignment

###
  GradebookViewModel
###
class GradeBookViewModel

  constructor: ->
    @assignements = ko.observableArray(DemoAssignements())
    @students = ko.observableArray(DemoStundents(@assignements()))

    @reverse_id = ko.observable(0);
    @reverse_lastname = ko.observable(0);
    @reverse_name = 0;

  sort_students_id: ->
    @reverse_id( if @reverse_id()>0 then @reverse_id()*-1 else 1)
    @students.sort((left,right)=>
        @reverse_id()*left.comparte_id_to(right)
      )

  sort_students_name: ->
    @students.sort((left,right)=>
        @reverse_name*left.comparte_name_to(right)
      )
    @reverse_name = @reverse_name*-1

  sort_students_lastname: ->
    @reverse_lastname( if @reverse_lastname()>0 then @reverse_lastname()*-1 else 1)
    @students.sort((left,right)=>
        @reverse_lastname()*left.comparte_lastname_to(right)
      )

  sort_students_final_grade:->
    return 

  breakpoint: ->
    console.log "breaking point"

  selected_asignments :->
    a for a in @assignements() when a.is_selected() && ! a._destroy

  ungroup:(assignment)->
    for part in assignment.parts()
      a = part.to_assignment()
      @assignements.push(a)
    @assignements.destroy(assignment)

  convert_selected_assignments_to_group: ->

    ass = new Assignement()
    ass.title("Grouped")

    selected = this.selected_asignments()
    first_index = @assignements.indexOf(selected[0])

    for a in selected
      for p in a.parts()
        #if a is not multiple, we set the title of the part as the title of the assignement
        p.title(a.title()) unless a.multiple()
        ass.parts.push(p)
      @assignements.remove(a)
    @assignements.splice(first_index,0,ass)

ko.applyBindings new GradeBookViewModel()
