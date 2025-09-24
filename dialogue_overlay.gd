extends CanvasLayer


@onready var dlabel = $dialogueLabel
@onready var textTimer = $textTimer
@onready var examplechar = preload('res://examplecharacter.tscn')

var talking = false
var currentDialogue = []
var dindex = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dlabel.text = ''


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and not talking and len(currentDialogue) > 0:
		dindex += 1
		if dindex < len(currentDialogue):
			playtext(currentDialogue[dindex])
		else:
			dman.sceneplaying = false
			dman.toggleclickables(false)
			self.queue_free()

func playtext(text:String)->void:
	talking = true
	if text.split(' ')[0] == '/c':
		var commands = text.split(' ')
		commands.remove_at(0)
		print(commands)
		exec(commands)
		dindex += 1
		playtext(currentDialogue[dindex])
	else:
		dlabel.text = ''
		for i in text:
			dlabel.text = dlabel.text + i
			if Input.is_action_pressed("ui_accept"):
				textTimer.start(.01)
			else:
				textTimer.start(.05)
			await textTimer.timeout
	talking = false
	

func playdialogue(dialogue: Array)->void:
	currentDialogue = dialogue
	playtext(currentDialogue[dindex])
	

func exec(commands:Array):
	match commands[0]:
		"inst":
			var chara = findcharacter(commands[1])
			var inst = chara.instantiate()
			inst.global_position = Vector2(int(commands[2]),int(commands[3]))
			add_child(inst)
		"animate":
			var chara = get_tree().get_first_node_in_group(commands[1])
			chara.changesprite(int(commands[2]))
			


func findcharacter(chara:String)-> PackedScene:
	match chara:
		"example":
			return examplechar
		_:
			print('could not find character requested')
			return examplechar
