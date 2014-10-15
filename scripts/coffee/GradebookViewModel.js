// Generated by CoffeeScript 1.8.0
(function() {
  var Assignement, AssignementPart, DemoAssignements, DemoStundents, Grade, GradeBookViewModel, Student;

  DemoAssignements = function() {
    var a;
    a = [
      new Assignement().initialize_data({
        title: "TP1",
        type: "Trabajo Practico",
        weight: "10",
        due_date: "30/6",
        parts: [
          new AssignementPart().initialize_data({
            title: "",
            weight: "100",
            due_date: "12/09"
          })
        ]
      }), new Assignement().initialize_data({
        title: "TP2",
        type: "Trabajo Practico",
        weight: "50",
        parts: [
          new AssignementPart().initialize_data({
            title: "Argumentacion",
            weight: "80",
            due_date: "12/09"
          }), new AssignementPart().initialize_data({
            title: "Debate",
            weight: "20",
            due_date: "20/09"
          })
        ]
      }), new Assignement().initialize_data({
        title: "TP3",
        type: "Trabajo Practico",
        weight: "50",
        parts: [
          new AssignementPart().initialize_data({
            title: "Resumen",
            weight: "10",
            due_date: "12/09"
          }), new AssignementPart().initialize_data({
            title: "Analisis Pagina",
            weight: "10",
            due_date: "12/09"
          }), new AssignementPart().initialize_data({
            title: "Resumen",
            weight: "20",
            due_date: "12/09"
          }), new AssignementPart().initialize_data({
            title: "Informe",
            weight: "60",
            due_date: "20/09"
          })
        ]
      }), new Assignement().initialize_data({
        title: "TP4 - Divulgacion",
        type: "Trabajo Practico",
        weight: "10",
        due_date: "30/6",
        parts: [
          new AssignementPart().initialize_data({
            title: "",
            weight: "100",
            due_date: "12/09"
          })
        ]
      }), new Assignement().initialize_data({
        title: "TP5",
        type: "Trabajo Practico",
        weight: "50",
        parts: [
          new AssignementPart().initialize_data({
            title: "Proyecto",
            weight: "10",
            due_date: "12/09"
          }), new AssignementPart().initialize_data({
            title: "CV",
            weight: "10",
            due_date: "12/09"
          }), new AssignementPart().initialize_data({
            title: "Presentacion",
            weight: "20",
            due_date: "12/09"
          }), new AssignementPart().initialize_data({
            title: "Afiche y Folleto",
            weight: "60",
            due_date: "20/09"
          })
        ]
      })
    ];
    return a;
  };

  DemoStundents = function(a) {
    var s;
    s = [
      new Student({
        id: 12223,
        name: "Julia",
        lastname: "Lasarte",
        comments: "Un comentario"
      }).initialize_grades(a), new Student({
        id: 465416,
        name: "Juan",
        lastname: "Perez",
        comments: ""
      }).initialize_grades(a), new Student({
        id: 45646,
        name: "Pedro",
        lastname: "Alcaucil",
        comments: ""
      }).initialize_grades(a), new Student({
        id: 13213,
        name: "Maria",
        lastname: "Brucelli",
        comments: ""
      }).initialize_grades(a), new Student({
        id: 45646,
        name: "Elena",
        lastname: "Ashifu",
        comments: "Un comentario"
      }).initialize_grades(a), new Student({
        id: 79878,
        name: "Pedro",
        lastname: "Soriano",
        comments: "Un comentario"
      }).initialize_grades(a)
    ];
    return s;
  };

  Student = (function() {
    function Student(data) {
      this.id = ko.observable(data.id);
      this.name = ko.observable(data.name);
      this.lastname = ko.observable(data.lastname);
      this.comments = ko.observable(data.comments);
      this.dropedout = ko.observable(false);
      this.grades = ko.observableArray([]);
      this.final_grade = ko.computed(function() {
        return 10;
      }, this);
    }

    Student.prototype.initialize_grades = function(assignments) {
      var assignment, part, _i, _j, _len, _len1, _ref;
      for (_i = 0, _len = assignments.length; _i < _len; _i++) {
        assignment = assignments[_i];
        _ref = assignment.parts();
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          part = _ref[_j];
          this.grades.push(new Grade(part));
        }
      }
      return this;
    };

    Student.prototype.comparte_id_to = function(another) {
      switch (false) {
        case this.id() !== another.id():
          return 0;
        case !(this.id() > another.id()):
          return 1;
        default:
          return -1;
      }
    };

    Student.prototype.comparte_lastname_to = function(another) {
      switch (false) {
        case this.lastname() !== another.lastname():
          return 0;
        case !(this.lastname() > another.lastname()):
          return 1;
        default:
          return -1;
      }
    };

    Student.prototype.comparte_name_to = function(another) {
      switch (false) {
        case this.name() !== another.name():
          return 0;
        case !(this.name() > another.name()):
          return 1;
        default:
          return -1;
      }
    };

    return Student;

  })();

  Grade = (function() {
    function Grade(assignment) {
      this.grade = ko.observable();
      this.text_grade = ko.observable();
      this.assignment = assignment;
      this.wieghted_grade = ko.computed(function() {
        return 10;
      }, this);
    }

    return Grade;

  })();

  Assignement = (function() {
    function Assignement(data) {
      this.title = ko.observable();
      this.type = ko.observable();
      this.weight = ko.observable();
      this.due_date = ko.observable();
      this.parts = ko.observableArray();
      this.is_selected = ko.observable(false);
      this.multiple = ko.computed(function() {
        return this.parts().length > 1;
      }, this);
    }

    Assignement.prototype.toggle_selection = function() {
      return this.is_selected(!this.is_selected());
    };

    Assignement.prototype.toAssignmentPart = function() {
      var part;
      part = new AssignementPart();
      part.title(this.title());
      part.due_date(this.due_date());
      part.weight(this.weight());
      return part;
    };

    Assignement.prototype.initialize_data = function(data) {
      this.title(data.title);
      this.type(data.type);
      this.weight(data.weight);
      this.due_date(data.due_date);
      this.parts(data.parts);
      return this;
    };

    Assignement.prototype.ungroup = function(parent) {
      return parent.ungroup(this);
    };

    return Assignement;

  })();

  AssignementPart = (function() {
    function AssignementPart() {
      this.due_date = ko.observable();
      this.weight = ko.observable();
      this.title = ko.observable();
    }

    AssignementPart.prototype.initialize_data = function(data) {
      this.due_date(data.due_date);
      this.weight(data.weight);
      this.title(data.title);
      return this;
    };

    AssignementPart.prototype.to_assignment = function() {
      var assignment;
      assignment = new Assignement();
      assignment.title(this.title());
      assignment.due_date(this.due_date());
      assignment.weight(this.weight());
      assignment.parts.push(this);
      return assignment;
    };

    return AssignementPart;

  })();


  /*
    GradebookViewModel
   */

  GradeBookViewModel = (function() {
    function GradeBookViewModel() {
      this.assignements = ko.observableArray(DemoAssignements());
      this.students = ko.observableArray(DemoStundents(this.assignements()));
      this.reverse_id = ko.observable(0);
      this.reverse_lastname = ko.observable(0);
      this.reverse_name = 0;
    }

    GradeBookViewModel.prototype.sort_students_id = function() {
      this.reverse_id(this.reverse_id() > 0 ? this.reverse_id() * -1 : 1);
      return this.students.sort((function(_this) {
        return function(left, right) {
          return _this.reverse_id() * left.comparte_id_to(right);
        };
      })(this));
    };

    GradeBookViewModel.prototype.sort_students_name = function() {
      this.students.sort((function(_this) {
        return function(left, right) {
          return _this.reverse_name * left.comparte_name_to(right);
        };
      })(this));
      return this.reverse_name = this.reverse_name * -1;
    };

    GradeBookViewModel.prototype.sort_students_lastname = function() {
      this.reverse_lastname(this.reverse_lastname() > 0 ? this.reverse_lastname() * -1 : 1);
      return this.students.sort((function(_this) {
        return function(left, right) {
          return _this.reverse_lastname() * left.comparte_lastname_to(right);
        };
      })(this));
    };

    GradeBookViewModel.prototype.sort_students_final_grade = function() {};

    GradeBookViewModel.prototype.breakpoint = function() {
      return console.log("breaking point");
    };

    GradeBookViewModel.prototype.selected_asignments = function() {
      var a, _i, _len, _ref, _results;
      _ref = this.assignements();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        a = _ref[_i];
        if (a.is_selected() && !a._destroy) {
          _results.push(a);
        }
      }
      return _results;
    };

    GradeBookViewModel.prototype.ungroup = function(assignment) {
      var a, part, _i, _len, _ref;
      _ref = assignment.parts();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        part = _ref[_i];
        a = part.to_assignment();
        this.assignements.push(a);
      }
      return this.assignements.destroy(assignment);
    };

    GradeBookViewModel.prototype.convert_selected_assignments_to_group = function() {
      var a, ass, first_index, p, selected, _i, _j, _len, _len1, _ref;
      ass = new Assignement();
      ass.title("Grouped");
      selected = this.selected_asignments();
      first_index = this.assignements.indexOf(selected[0]);
      for (_i = 0, _len = selected.length; _i < _len; _i++) {
        a = selected[_i];
        _ref = a.parts();
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          p = _ref[_j];
          if (!a.multiple()) {
            p.title(a.title());
          }
          ass.parts.push(p);
        }
        this.assignements.remove(a);
      }
      return this.assignements.splice(first_index, 0, ass);
    };

    return GradeBookViewModel;

  })();

  ko.applyBindings(new GradeBookViewModel());

}).call(this);
