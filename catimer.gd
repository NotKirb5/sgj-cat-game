extends CanvasLayer

signal finish

@onready var timer = $Timer
@onready var timerbar = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.time_left != 0:
		timerbar.scale.x = timer.time_left * .2


func _on_timer_timeout() -> void:
	finish.emit()
	self.queue_free()
