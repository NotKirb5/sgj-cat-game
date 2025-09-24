extends Node2D

@onready var sprites = $sprites
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# in order to chage the character expressions you just change the spriteframe
func changesprite(sprite:int)->void:
	sprites.frame = sprite
