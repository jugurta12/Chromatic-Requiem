extends CharacterBody2D

var controls_enabled = true
@export var gravity = 700
@export var speed = 200
@export var acceleration = 0.2
@export var jump_force = 430
@onready var sprite = $AnimatedSprite2D
var facing_right = true
var is_attacking = false
var health = 50
var max_health = 50
signal health_changed(new_health)

func _physics_process(delta):
	if !is_on_floor():
		velocity.y = clamp(velocity.y + gravity * delta, -500, 500)
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction != 0:
		facing_right = direction > 0
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	if Input.is_action_just_pressed("atk") and !is_attacking:
		attack_sequence()
	
	velocity.x = lerp(velocity.x, direction * speed, acceleration)
	update_animation(direction)
	move_and_slide()

func attack_sequence():
	is_attacking = true
	# Première animation d'attaque selon la direction
	sprite.play("atk1_right" if facing_right else "atk1_left")
	await get_tree().create_timer(0.5).timeout 
	is_attacking = false

func update_animation(direction):
	# Ne pas changer l'animation si on est en train d'attaquer
	if is_attacking:
		return
		
	if is_on_floor():
		if direction == 0:
			sprite.play("idle_right" if facing_right else "idle_left")
		else:
			sprite.play("run_right" if facing_right else "run_left")
	else:
		sprite.play("jump_right" if facing_right else "jump_left")

func _on_attack_timer_timeout():
	get_tree().root.get_node("Arcade/HealthBar").update_health_bar()
	is_attacking = false

func _ready():
	emit_signal("health_changed", health)
