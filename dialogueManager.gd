extends Node

var scene = 'test'
var storydict = {
		"test": ['/c inst example 200 600','i want a big mac rn not gonna lie','im not even that hungry i just want onions', '/c animate examplecharacter 2','and NO PICKLES','rip haru urara']

}
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

func toggleclickables(b:bool)->void:
	var clickables = get_tree().get_nodes_in_group('clickable')
	for i in clickables:
		i.disabled = b
