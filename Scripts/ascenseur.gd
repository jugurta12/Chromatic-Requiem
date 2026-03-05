extends Area2D

@onready var animated_sprite = $elevatorinteract
@onready var collision_sprite = $CollisionShape2D
var player_nearby = false
signal down
var up = false

func _ready():
	animated_sprite.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "tutobaadie":
		await get_tree().create_timer(0.3).timeout
		player_nearby = true
		animated_sprite.visible = true
		animated_sprite.play("down")  # Joue l'animation

func _on_body_exited(body):
	if body.name == "tutobaadie":
		await get_tree().create_timer(0.3).timeout
		player_nearby = false
		animated_sprite.stop()
		animated_sprite.visible = false

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("ui_accept"):
		interact()

func interact():
	if up == false:
		emit_signal("down")
		animated_sprite.visible = false
		up = true
	if up == true:
		emit_signal("up")
		animated_sprite.visible = false
		up = true
	else:
		pass
