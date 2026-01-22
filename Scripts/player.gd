extends CharacterBody2D
var controls_enabled = true
@export var gravity = 700
@export var speed = 200
@export var acceleration = 0.2
@export var jump_force = 430
@onready var sprite = $AnimatedSprite2D
@onready var attack_area = $AttackArea  
var facing_right = true    
var is_attacking = false
var health = 100
var max_health = 100
signal health_changed(new_health)
var gameover_scene = preload("res://Scenes/game_over.tscn")

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
	sprite.play("atk1_right" if facing_right else "atk1_left")
	
	# Attendre un peu avant de détecter les coups (timing de l'animation)
	await get_tree().create_timer(0).timeout
	
	# Détecter les ennemis dans la zone d'attaque
	if attack_area:
		var enemies = attack_area.get_overlapping_bodies()
		for enemy in enemies:
			if enemy.has_method("take_damage"):
				enemy.take_damage(1)
	
	await get_tree().create_timer(0.3).timeout 
	is_attacking = false

func update_animation(direction):
	if is_attacking:
		return
		
	if is_on_floor():
		if direction == 0:
			sprite.play("idle_right" if facing_right else "idle_left")
		else:
			sprite.play("run_right" if facing_right else "run_left")
	else:
		sprite.play("jump_right" if facing_right else "jump_left")

func _ready():
	sprite.play("idle_right")
	emit_signal("health_changed", health)

func _on_ennemis_dmg(amount: Variant) -> void:
	if !is_attacking:
		health -= amount
		emit_signal("health_changed", health)
		var knockback = Vector2(-1200, -200) 
		if not facing_right:
			knockback.x *= -1 
		if health == 0: 
			set_physics_process(false)
			set_process(false)
			set_process_input(false)
			velocity = Vector2.ZERO
			sprite.play("death1")
			await get_tree().create_timer(1.9).timeout
			sprite.play("death2")
			await get_tree().create_timer(0.999).timeout
			visible = false
			await get_tree().create_timer(0.2).timeout
			get_tree().paused = true
			var gameover_instance = gameover_scene.instantiate()
			get_tree().root.add_child(gameover_instance)
			queue_free()
			return
		velocity += knockback
		controls_enabled = false
		await get_tree().create_timer(0.3).timeout
		controls_enabled = true
