extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -200.0
signal dial1()
signal hitting()

@onready var anime = $AnimatedSprite2D
@onready var attack_area = $AttackArea
@onready var signall = get_node("../AudioStreamPlayer2D")
@onready var transfo = get_node("../AudioStreamPlayer2D2")
var can_move = false 
var done = false
var is_attacking = false

var facing_right = true # Par défaut, il regarde à droite

func _physics_process(delta: float) -> void:
	# Gravité
	if not is_on_floor():
		velocity += get_gravity() * delta

	if can_move and is_attacking == false:
		# 1. Saut
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# 2. Mouvement
		var direction := Input.get_axis("ui_left", "ui_right")
		
		if direction != 0:
			velocity.x = direction * SPEED
			
			facing_right = direction > 0 
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		
		if not is_on_floor( ) and can_move==true:
			
			if facing_right:
				anime.play("jump_right")
			else:
				anime.play("jump_left")
				
		elif direction != 0 and can_move==true:
			# --- AU SOL ET MARCHE ---
			if facing_right:
				anime.play("run_right")
			else:
				anime.play("run_left")
				
		else:
			
			if facing_right:
				anime.play("idle_right")
			else:
				anime.play("idle_left") 
				
		

	elif done == true and is_attacking == false:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if facing_right:
			anime.play("idle_right")
		else:
			anime.play("idle_left")
	move_and_slide()
	
	if can_move and is_attacking == false:
		
		if Input.is_action_just_pressed("atk") and is_on_floor():
			is_attacking = true
			velocity.x = 0 
			attack_area.monitoring = true
			if facing_right:
				anime.play("atk1_right")
			else :
				anime.play("atk1_left")
			await get_tree().create_timer(0.5).timeout
			attack_area.monitoring = false
			is_attacking = false



func _ready() -> void:
	anime.play("idle_rightA")
	can_move = false
func _on_canvas_layer_end() -> void:
	await get_tree().create_timer(3.0).timeout
	signall.play()
	anime.play("virus")
	await get_tree().create_timer(1.8).timeout
	transfo.play()
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


func _on_dial_1() -> void:
	done = true
	
func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.name == "scarecrow" and is_attacking == true:
		hitting.emit()
