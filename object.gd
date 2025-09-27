extends Node2D

var triggered = false
@onready var sprite = $sprite
@onready var btn = $Button
var tumblepos = null
var object = ''
var newobj = preload('res://inksplat.tscn')
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.frame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if not triggered:
		sprite.frame = 1
		triggered = true
		scale = Vector2(1,1)
		cman.points += 1
		if tumblepos:
			print(tumblepos)
			self.global_position = tumblepos
		if object =="ink":
			var inst = newobj.instantiate()
			inst.global_position = Vector2(1064,516)
			add_sibling(inst)
		if object.begins_with("sticker"):
			cman.spoints += 1


func _on_button_mouse_entered() -> void:
	if not triggered:
		scale = Vector2(1.2,1.2)

func disable()->void:
	btn.disabled = true
	triggered = true
	scale = Vector2(1,1)

func _on_button_mouse_exited() -> void:
	scale = Vector2(1,1)

func init(list:Array)->void:
	sprite.set_animation(list[0])
	object = list[0]
	print(list)
	if len(list) > 3:
		tumblepos = Vector2(int(list[3]),int(list[4]))
