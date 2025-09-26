extends Node2D

@onready var sprites = $sprites
var defocusing = false
var focusing = true
var spawning = true
var dying = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawning:
		self.modulate.a = move_toward(self.modulate.a,1,1*delta)
		if self.modulate.a >= 1:
			spawning = false
	if dying:
		self.modulate.a = move_toward(self.modulate.a,0,1*delta)
		if self.modulate.a <= 0:
			self.queue_free()
	#i feel like theres a better way to do this but it loosk nicer in the game so it dont matter
	if defocusing:
		self.modulate.a = move_toward(self.modulate.a,0.7,3*delta)
		self.scale.x = move_toward(self.scale.x,0.9,3*delta)
		self.scale.y = move_toward(self.scale.y,0.9,3*delta)
		if self.modulate.a <= 180 and self.scale.x <= 0.8 and self.scale.y <= 0.8:
			defocusing = false
	elif focusing:
		self.modulate.a = move_toward(self.modulate.a,1,3*delta)
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
	spawning = false
	defocusing = true

func focus()->void:
	defocusing = false
	focusing = true

func flipsprite()->void:
	sprites.flip_h = !sprites.flip_h
