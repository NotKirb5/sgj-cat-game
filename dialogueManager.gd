extends Node

var scene = 'test'

#stores dialogue in a dictonary and gets stored in a list
#when the sript comes out id want to make it a seprate file
var storydict = {
		"test": ['/c inst example 200 600','/c settalk Pheonix','i want a big mac rn not gonna lie','im not even that hungry i just want onions', '/c animate examplecharacter 2','and NO PICKLES','rip haru urara']

}

#every scene will create a new overlay and when the scene ends it will delete itself
@onready var overlay = preload("res://dialogue_overlay.tscn")
var sceneplaying = false


func playscene(s:String)->void:
	if not sceneplaying:
		sceneplaying = true
		toggleclickables(true)
		scene = s
		var inst = overlay.instantiate()
		add_child(inst)
		inst.playdialogue(storydict[scene])

#disables clickables when dialogue is going so we dont run into weird stuff
func toggleclickables(b:bool)->void:
	var clickables = get_tree().get_nodes_in_group('clickable')
	for i in clickables:
		i.disabled = b
