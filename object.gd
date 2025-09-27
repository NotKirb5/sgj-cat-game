extends Node2D

var triggered = false
@onready var sprite = $sprite
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	sprite.frame = 1
	triggered = true
	cman.points += 1


func _on_button_mouse_entered() -> void:
	if not triggered:
		scale = Vector2(1.2,1.2)


func _on_button_mouse_exited() -> void:
	scale = Vector2(1,1)
