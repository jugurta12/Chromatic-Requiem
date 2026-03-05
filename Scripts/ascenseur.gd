extends Area2D

@onready var animated_sprite = $elevatorinteract
@onready var collision_sprite = $CollisionShape2D
var player_nearby = false
signal down
signal up
var upp = false
var animating = false

func _ready():
	animated_sprite.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "tutobaadie":
		await get_tree().create_timer(0.1).timeout
		player_nearby = true
		animated_sprite.visible = true
		animated_sprite.play("down")  # Joue l'animation

func _on_body_exited(body):
	if body.name == "tutobaadie":
		await get_tree().create_timer(0.1).timeout
		player_nearby = false
		animated_sprite.stop()
		animated_sprite.visible = false

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("ui_accept"):
		interact()

func interact():
	if upp == false and animating == false:
		emit_signal("down")
		animating = true
		animated_sprite.visible = false
		upp = true
		await get_tree().create_timer(5).timeout
		animating = false
	elif upp == true and animating == false:
		emit_signal("up")
		animating = true
		animated_sprite.visible = false
		upp = false
		await get_tree().create_timer(5).timeout
		animating = false
	else:
		pass
