extends CanvasLayer

@onready var label = $RichTextLabel
@onready var timer = $Timer

var dialogues = ["Bonjour l'ami !", "C'est moi qui ai dessiné ce fond, pas mal non ?", "Allez, bon vent !"]
var dialogue_index = 0
var is_typing = false

func _ready():
	timer.wait_time = 0.05 # Vitesse d'écriture
	start_dialogue()

func _input(event):
	if event.is_action_pressed("interact"): # "ui_accept" est la touche Entrée par défaut
		if is_typing:
			# Si on est en train d'écrire, on affiche tout d'un coup
			finish_typing()
		else:
			# Sinon, on passe au dialogue suivant
			dialogue_index += 1
			if dialogue_index < dialogues.size():
				start_dialogue()
			else:
				queue_free() # Plus de dialogues ? On ferme la boîte.

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
