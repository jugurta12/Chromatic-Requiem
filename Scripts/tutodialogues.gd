extends CanvasLayer

@onready var label = $RichTextLabel
@onready var timer = $Timer
signal end()
signal end2()
var un = 1

var dialogues = ["Unknown voice: Come, come ...",
 "..." ,
"Unknown voice: Come, and see how the world has changed, and how your faith writes your steps from now on, towards greatness.", 
"Baadie : Ugh... ",
"Baadie : My head... Who's talking?"]
var dialogue_index = 0
var is_typing = false

func _ready():
	visible = false
	await get_tree().create_timer(6.0).timeout
	visible = true
	timer.wait_time = 0.07
	start_dialogue()

func _input(event):
	if visible and event.is_action_pressed("interact"):
		if is_typing:
			
			finish_typing()
		else:
			
			dialogue_index += 1
			if dialogue_index < dialogues.size():
				start_dialogue()
			else :
				visible = false
				un -= 1
				if un == 0 :
					end.emit()
				if un == -1 :
					end2.emit()

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


func _on_tutobaadie_dial_1() -> void:
	dialogues = ["Unknown voice: Here, I give you my blessing.",
 	"Unknown voice: The world you once knew has withered into a shadow of its former self." ,
	"Unknown voice: Take heed, for the line between a gift and a burden is thin; what you embrace as a blessing,", 
	"Unknown voice:  your heart may yet find to be a curse.",
	"Unknown voice:  Now go, follow the path to seek the truth that has become blurred.",]
	dialogue_index = 0
	await get_tree().create_timer(3.0).timeout
	visible = true
	start_dialogue()
	
