extends Node

var scene = 'test'

#stores dialogue in a dictonary and gets stored in a list
#when the sript comes out id want to make it a seprate file
var storydict = {
		"test": ['/c inst sp 500 500','/c settalk Sweet_Potato','i want a big mac rn not gonna lie','/c defocus sp','im not even that hungry i just want onions','/c focus sp','and NO PICKLES','/c defocus sp','rip haru urara'],
		'test2': ['/c inst sp 500 500', '/c settalk Sweet_Potoato', 'meow :3', '/c inst examplecharacter 1400 500', '/c focus examplecharacter','/c defocus sp', '/c settalk Koishi','omg gato', '/c focus sp', '/c defocus examplecharacter','/c settalk Sweet_Potato','meow :>', '/c animate examplecharacter 2','/c focus examplecharacter','/c defocus sp', '/c settalk Yuyuko','looks pretty edible','yummy', '/c defocus examplecharacter','/c focus sp','/c settalk Sweet_Potato','MEOW!!!']

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
