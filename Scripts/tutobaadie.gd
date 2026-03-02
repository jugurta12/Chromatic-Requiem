extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anime = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _ready() -> void:
	anime.play("idle_rightA")

func _on_canvas_layer_end() -> void:
	await get_tree().create_timer(3.0).timeout
	anime.play("virus")
	await get_tree().create_timer(1.8).timeout
	anime.play("virustransfo")
	await get_tree().create_timer(0.9999).timeout
	anime.play("virusrest")
	await get_tree().create_timer(1.9999).timeout
	anime.play("idle_right")
