extends Node2D
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	loop_animations()

func loop_animations():
	anim.play("default")
	await get_tree().create_timer(5.00).timeout

	anim.play("anim")
	await get_tree().create_timer(0.99).timeout

	anim.play("default2")
	await get_tree().create_timer(5.0).timeout

	anim.play("anim2")
	await get_tree().create_timer(0.99).timeout

	loop_animations()  # recommence
