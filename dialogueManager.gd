extends Node

var scene = 'test'

#stores dialogue in a dictonary and gets stored in a list
#when the sript comes out id want to make it a seprate file


var storydict = {}

#every scene will create a new overlay and when the scene ends it will delete itself
@onready var overlay = preload("res://dialogue_overlay.tscn")
var sceneplaying = false

	
	
func playscene(s:String)->void:
	var file = FileAccess.open("res://script.json", FileAccess.READ)
	var json_text = file.get_as_text()
	var result = JSON.parse_string(json_text)
	if not sceneplaying:
		sceneplaying = true
		scene = s
		var inst = overlay.instantiate()
		add_child(inst)
		inst.playdialogue(result[scene])

#disables clickables when dialogue is going so we dont run into weird stuff
