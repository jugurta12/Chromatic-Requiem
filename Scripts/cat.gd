extends Area2D

@onready var animated_sprite = $petsprite
@onready var collision_sprite = $CollisionShape2D
@onready var milo_purr = $milopurr
var player_nearby = false
signal pet

func _ready():
	animated_sprite.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "persomenu":
		await get_tree().create_timer(0.3).timeout
		player_nearby = true
		animated_sprite.visible = true
		animated_sprite.play("pet")  # Joue l'animation

func _on_body_exited(body):
	if body.name == "persomenu":
		await get_tree().create_timer(0.3).timeout
		player_nearby = false
		animated_sprite.stop()
		animated_sprite.visible = false

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("ui_accept"):
		interact()

func interact():
	emit_signal("pet")
	animated_sprite.visible = false
	await get_tree().create_timer(1).timeout
	animated_sprite.visible = true
	milo_purr.play()
	animated_sprite.play("heart") 
	await get_tree().create_timer(3).timeout
	collision_sprite.disabled = true
	await get_tree().create_timer(3.3).timeout
	milo_purr.stop()
	await get_tree().create_timer(8).timeout
	collision_sprite.disabled = false
