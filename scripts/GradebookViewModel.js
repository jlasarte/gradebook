function Student(data) {
	var self = this;
	self.id = ko.observable(data.id)
	self.name = ko.observable(data.name);
	self.lastname = ko.observable(data.lastname);	
}

function DemoStundents() {
	
	var s = 
	[
		{id:12223, 	name:"Julia", 	lastname:"Lasarte"},
		{id:2389, 	name:"Pedro", 	lastname:"Perez"},
		{id:123231, name:"Juan",	lastname:"Peron"},
		{id:18041, 	name:"Maria", 	lastname:"Gomez"},
		{id:780, 	name:"Elena", 	lastname:"Algo"},
		{id:12333, 	name:"Mirta", 	lastname:"Sarasa"},
		{id:42321, 	name:"Martin", 	lastname:"Chan"}
	];

	return s;
}

function GradeBookViewModel() {
	var self = this;

	self.students = ko.observableArray(DemoStundents());
}

ko.applyBindings(new GradeBookViewModel());