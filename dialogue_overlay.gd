extends CanvasLayer


@onready var dlabel = $dialogueLabel
@onready var nlabel = $namelabel
@onready var textTimer = $textTimer

#when more characters get added load them up here
@onready var char = preload('res://character.tscn')

var talking = false
var currentDialogue = []
var dindex = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dlabel.text = ''
	nlabel.text = ''


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#moving on with the dialogue
	# if there is no more dialogue the scene kills itself
	if Input.is_action_just_pressed("ui_accept") and not talking and len(currentDialogue) > 0:
		dindex += 1
		if dindex < len(currentDialogue):
			playtext(currentDialogue[dindex])
		else:
			dman.sceneplaying = false
			dman.toggleclickables(false)
			self.queue_free()

func playtext(text:String)->void:
	# if the string starts with /c it splits the string and tries to run a command
	#otherwise it will just run the text as normal
	if text.split(' ')[0] == '/c':
		var commands = text.split(' ')
		commands.remove_at(0)
		print(commands)
		exec(commands)
		dindex += 1
		playtext(currentDialogue[dindex])
	else:
		talking = true
		
		dlabel.text = ''
		for i in text:
			dlabel.text = dlabel.text + i
			#if you hold spacebar the text displays faster
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
	#most jank part of this whole thing
	# inst will spawn the character ['inst', character group, x position, y position]
	# animate will change the frame of the character ['animate',character group, sprite index]
	# animate gets the character by its group in order to actually get it
	# settalk sets the label at the top to signify who is talking ['settalk', name]
	#IMPORTANT when setting a name with 2 words use a underscore to seperate it
	#focus and defocus are in the name ["focus"/"defocus", character group]
	#
	match commands[0]:
		"inst":
			var inst = char.instantiate()
			inst.add_to_group(commands[1])
			inst.global_position = Vector2(int(commands[2]),int(commands[3]))
			add_child(inst)
			inst.setcharacter(commands[1])
			
		"animate":
			var chara = get_tree().get_first_node_in_group(commands[1])
			chara.changesprite(int(commands[2]))
		"settalk":
			var name = PackedStringArray(commands[1].split("_"))
			nlabel.text = " ".join(name)
		"defocus":
			var chara = get_tree().get_first_node_in_group(commands[1])
			chara.defocus()
		"focus":
			var chara = get_tree().get_first_node_in_group(commands[1])
			chara.focus()
		"flip":
			var chara = get_tree().get_first_node_in_group(commands[1])
			chara.flipsprite(commands[2])
