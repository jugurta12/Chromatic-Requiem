extends CharacterBody2D
const SPEED = 80.0
const GRAVITY = 900.0
const STOP_DISTANCE = 4.0
const SMOOTH = 8.0 
var target : Node2D = null
var attacking = false
var facing_right = true
var amount = 25
var life = 2
signal dmg(amount)
signal kill
@onready var anim = $AnimatedSprite2D
@onready var atksound = $atksound

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
		var direction = sign(dx)
		desired_x = direction * SPEED
		# Mettre à jour l'orientation
		if direction != 0:
			facing_right = direction > 0
	velocity.x = lerp(velocity.x, desired_x, clamp(SMOOTH * delta, 0, 1))
	move_and_slide()
	# Jouer l'animation par défaut si pas en attaque
	if not attacking:
		if facing_right:
			anim.play("default2")
		else:
			anim.play("default")
	# Vérifier collision avec baadie pour attaquer
	if not attacking and is_touching_player():
		play_attack()

func is_touching_player() -> bool:
	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i)
		if col.get_collider() == target:
			return true
	return false

func play_attack():
	emit_signal("dmg", amount)
	atksound.play()
	attacking = true
	if facing_right:
		anim.play("atk2")
	else:
		anim.play("atk")
	velocity.x = 0
	await get_tree().create_timer(0.5).timeout
	if facing_right:
		anim.play("default2")
	else:
		anim.play("default")
	await get_tree().create_timer(1).timeout
	attacking = false

# Nouvelle fonction pour recevoir les dégâts
func take_damage(dmg: int) -> void:
	life -= dmg
	# Knockback dans la direction opposée à l'orientation
	var knockback_direction = -1 if facing_right else 1
	var knockback = Vector2(knockback_direction * 1200, -600)
	velocity = knockback
	if life <= 0:
		emit_signal("kill")  
		set_physics_process(false)  
		await get_tree().create_timer(0.01).timeout 
		queue_free()
