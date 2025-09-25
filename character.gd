extends Node2D

@onready var sprites = $sprites
var defocusing = false
var focusing = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#i feel like theres a better way to do this but it loosk nicer in the game so it dont matter
	if defocusing:
		self.modulate.a = move_toward(self.modulate.a,0.8,1*delta)
		self.scale.x = move_toward(self.scale.x,0.8,3*delta)
		self.scale.y = move_toward(self.scale.y,0.8,3*delta)
		if self.modulate.a <= 180 and self.scale.x <= 0.8 and self.scale.y <= 0.8:
			defocusing = false
	elif focusing:
		self.modulate.a = move_toward(self.modulate.a,1,1*delta)
		self.scale.x = move_toward(self.scale.x,1,1*delta)
		self.scale.y = move_toward(self.scale.y,1,1*delta)
		if self.modulate.a >= 255 and self.scale.x >= 1 and self.scale.y >= 1:
			defocusing = false

# in order to chage the character expressions you just change the spriteframe
func changesprite(sprite:int)->void:
	sprites.frame = sprite

func setcharacter(c:String)->void:
	sprites.set_animation(c)

func defocus()->void:
	focusing = false
	defocusing = true

func focus()->void:
	defocusing = false
	focusing = true

func flipsprite(f:bool)->void:
	sprites.flip_v = f
