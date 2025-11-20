extends CharacterBody2D

const SPEED = 80.0
const GRAVITY = 900.0
const STOP_DISTANCE = 4.0
const SMOOTH = 8.0 

var target : Node2D = null
var attacking = false

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	# Trouver baadie si pas encore trouvé
	if target == null:
		if has_node("../CharacterBody2D"):
			target = get_node("../CharacterBody2D")
		else:
			return

	# Gravité
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	# Déplacement horizontal smooth
	var dx = target.global_position.x - global_position.x
	var desired_x = 0.0
	if abs(dx) > STOP_DISTANCE:
		desired_x = sign(dx) * SPEED
	velocity.x = lerp(velocity.x, desired_x, clamp(SMOOTH * delta, 0, 1))

	move_and_slide()

	# Jouer l'animation par défaut si pas en attaque
	if not attacking:
		$AnimatedSprite2D.play("default")

	# Vérifier collision avec baadie pour attaquer
	if not attacking and is_touching_player():
		play_attack()


# Fonction pour vérifier si l'ennemi touche baadie
func is_touching_player() -> bool:
	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i)
		if col.get_collider() == target:
			return true
	return false


# Fonction pour gérer l'attaque
func play_attack():
	attacking = true
	anim.play("atk")
	velocity.x = 0  # stop l'ennemi pendant l'attaque
	await get_tree().create_timer(0.5).timeout
	anim.play("default")
	attacking = false
