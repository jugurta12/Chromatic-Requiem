extends CharacterBody2D

const SPEED = 200.0
const GRAVITY = 900.0
const STOP_DISTANCE = 4.0
const SMOOTH = 8.0  # plus grand => plus rapide la correction

var target : Node2D = null

func _physics_process(delta):
	if target == null:
		if has_node("../CharacterBody2D"):
			target = get_node("../CharacterBody2D")
		else:
			return

	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	var dx = target.global_position.x - global_position.x
	var desired_x = 0.0
	if abs(dx) > STOP_DISTANCE:
		desired_x = sign(dx) * SPEED
	# Interpoler la vitesse pour plus de smooth
	velocity.x = lerp(velocity.x, desired_x, clamp(SMOOTH * delta, 0, 1))

	move_and_slide()
