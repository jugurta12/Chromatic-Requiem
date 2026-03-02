extends CanvasLayer

@onready var label = $RichTextLabel
@onready var timer = $Timer

var dialogues = ["Unknown voice: Come, come ...",
 "..." ,
"Unknown voice: Come, and see how the world has changed, and how your faith writes your steps from now on, towards greatness.", 
"Baadie : Ugh... ",
"Baadie : My head... Who's talking?"]
var dialogue_index = 0
var is_typing = false

func _ready():
	timer.wait_time = 0.07 
	start_dialogue()

func _input(event):
	if event.is_action_pressed("interact"): 
		if is_typing:
			
			finish_typing()
		else:
			
			dialogue_index += 1
			if dialogue_index < dialogues.size():
				start_dialogue()
			else:
				queue_free() 

func start_dialogue():
	label.text = dialogues[dialogue_index]
	label.visible_characters = 0
	is_typing = true
	timer.start()

func _on_timer_timeout():
	if label.visible_characters < label.text.length():
		label.visible_characters += 1
	else:
		finish_typing()

func finish_typing():
	label.visible_characters = label.text.length()
	is_typing = false
	timer.stop()
