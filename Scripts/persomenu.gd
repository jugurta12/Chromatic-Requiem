extends CharacterBody2D
const SPEED = 150.0
const VERTICAL_SPEED = 100.0
@onready var animated_sprite = $AnimatedSprite2D
var last_direction = "right"
var is_petting = false  # Nouvelle variable

func _physics_process(delta: float) -> void:
	# Si le perso est en train de caresser, on bloque tout mouvement
	if is_petting:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		animated_sprite.play("run_right")
		last_direction = "right"
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		animated_sprite.play("run_left")
		last_direction = "left"
	elif Input.is_action_pressed("ui_down"):
		velocity.y = VERTICAL_SPEED
		animated_sprite.play("down")
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -VERTICAL_SPEED
		animated_sprite.play("up")
	else:
		if last_direction == "right":
			animated_sprite.play("idle_right")
		else:
			animated_sprite.play("idle_left")
	
	move_and_slide()

func _on_cat_pet() -> void:
	is_petting = true
	animated_sprite.play("cat")
	
	# Timer de 3 secondes
	await get_tree().create_timer(3.0).timeout
	
	is_petting = false
	# Retour à l'idle selon la dernière direction
	if last_direction == "right":
		animated_sprite.play("idle_right")
	else:
		animated_sprite.play("idle_left")
