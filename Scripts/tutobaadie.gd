extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -200.0
signal dial1()

@onready var anime = $AnimatedSprite2D
var can_move = false 

var facing_right = true # Par défaut, il regarde à droite

func _physics_process(delta: float) -> void:
	# Gravité
	if not is_on_floor():
		velocity += get_gravity() * delta

	if can_move:
		# 1. Saut
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# 2. Mouvement
		var direction := Input.get_axis("ui_left", "ui_right")
		
		if direction != 0:
			velocity.x = direction * SPEED
			# Mise à jour de la direction du regard
			facing_right = direction > 0 
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		# 3. GESTION DES ANIMATIONS
		if not is_on_floor():
			# --- EN L'AIR ---
			if facing_right:
				anime.play("jump_right")
			else:
				anime.play("jump_left")
				
		elif direction != 0:
			# --- AU SOL ET MARCHE ---
			if facing_right:
				anime.play("run_right")
			else:
				anime.play("run_left")
				
		else:
			# --- AU SOL ET ARRÊTÉ (IDLE) ---
			if facing_right:
				anime.play("idle_right")
			else:
				anime.play("idle_left") # Enfin ton perso regarde à gauche !

	else:
		# Si can_move est faux (dialogue, etc.)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# On joue l'Idle selon la dernière direction enregistrée
		if facing_right:
			anime.play("idle_right")
		else:
			anime.play("idle_left")

	move_and_slide()

func _ready() -> void:
	anime.play("idle_rightA")
	can_move = false
func _on_canvas_layer_end() -> void:
	await get_tree().create_timer(3.0).timeout
	anime.play("virus")
	await get_tree().create_timer(1.8).timeout
	anime.play("virustransfo")
	await get_tree().create_timer(1.0).timeout
	anime.play("virusrest")
	await get_tree().create_timer(1.9).timeout
	anime.play("idle_right")
	dial1.emit()
	


func _on_canvas_layer_end_2() -> void:
	await get_tree().create_timer(1.9).timeout
	can_move = true


func _on_area_2d_down() -> void:
	can_move = false
	await get_tree().create_timer(4).timeout
	can_move = true


func _on_area_2d_up() -> void:
	can_move = false
	await get_tree().create_timer(4).timeout
	can_move = true
