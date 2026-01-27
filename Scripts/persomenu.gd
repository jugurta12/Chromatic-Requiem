extends CharacterBody2D

const SPEED = 150.0
const VERTICAL_SPEED = 100.0

@onready var animated_sprite = $AnimatedSprite2D
var last_direction = "right" 

func _physics_process(delta: float) -> void:
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
		animated_sprite.play("run_right")
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -VERTICAL_SPEED
		animated_sprite.play("run_right")
	else:
		if last_direction == "right":
			animated_sprite.play("idle_right")
		else:
			animated_sprite.play("idle_left")
	
	move_and_slide()
