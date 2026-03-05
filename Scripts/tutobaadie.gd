extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
signal dial1()

@onready var anime = $AnimatedSprite2D

# Variable pour bloquer/autoriser le mouvement
var can_move = false 

func _physics_process(delta: float) -> void:
	# On applique toujours la gravité
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Si le mouvement est autorisé
	if can_move:
		# Saut
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Déplacement gauche/droite
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
			# Optionnel : pour que le sprite se tourne dans la bonne direction
			anime.flip_h = (direction < 0)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		# Si on ne peut pas bouger, on freine jusqu'à l'arrêt
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _ready() -> void:
	# Au début, on joue l'anim et on bloque le mouvement pour le dialogue
	anime.play("idle_rightA")
	can_move = false

# Cette fonction se lance quand le dialogue est fini (signal "end")
func _on_canvas_layer_end() -> void:
	# On attend les 3 secondes prévues
	await get_tree().create_timer(3.0).timeout
	
	# Séquence de transformation
	anime.play("virus")
	await get_tree().create_timer(1.8).timeout
	
	anime.play("virustransfo")
	await get_tree().create_timer(1.0).timeout
	
	anime.play("virusrest")
	await get_tree().create_timer(1.9).timeout
	
	# Retour à la normale
	anime.play("idle_right")
	dial1.emit()
	


func _on_canvas_layer_end_2() -> void:
	await get_tree().create_timer(1.9).timeout
	can_move = true
