extends Node


var points = 0
var spoints = 0
@onready var obj = preload("res://object.tscn")
@onready var cattimer = preload('res://catimer.tscn')

var gamescenes ={
	"tuto": ['monitor 1075 470 1056 476','keyboard 1032 562 1064 505','yarn 356 387 405 572','stapler 1358 601 1319 606'],
	"cat1": ['books 1249 297 1304 605','ink 713 202 665 105','eraser 797 512 738 531','paper 1475 695'],
	"cat2": ['paperstack 621 512 622 628','chair 816 707','headphones 1146 623 798 961','box 359 802','pencils 1361 732'],
	"cat3": ['washitape 1215 142 1085 525','totebag 948 315','pencilcase 823 370 793 271','coffee 1117 580 1085 604','shelf 239 191 405 172']
}

func cleanup():
	pass
	#var items = get_tree.


func startcat(scene:String,nextscene:String)->void:
	var items = gamescenes[scene]
	var mainscene = get_tree().get_first_node_in_group('main')
	for i in items:
		var list = i.split(' ')
		var inst = obj.instantiate()
		inst.global_position = Vector2(int(list[1]),int(list[2]))
		mainscene.add_child(inst)
		inst.init(list)
	var inst = cattimer.instantiate()
	add_child(inst)
	await inst.finish
	print('cattimer finished')
	var clickables = get_tree().get_nodes_in_group('clickable')
	for e in clickables:
		e.disable()
	dman.playscene(nextscene)
