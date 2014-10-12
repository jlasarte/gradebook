class ColorSchemeSettings
	constructor:->
		@background: ko.observable()
		@text: ko.observable()

class UISettings
	constructor:->
		@font = ko.observable()
		@colorscheme = ko.observable(new ColorSchemeSettings())

class ClassSettings
	constructor: ->
		@gradingscheme = ko.observable(new GradingSchemeSettings())

class SettingsViewModel

	constructor:->
		@UISettings = ko.observable(new UISettings())
		@GradingSettings = ko.observable(new GradingSettings())
		@ClassSettings =  ko.observable(new ClassSettings())

