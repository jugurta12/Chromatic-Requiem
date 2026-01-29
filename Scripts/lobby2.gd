extends Node2D
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var menusound = $menusound

func _ready():
	loop_animations()
	menusound.play()
func loop_animations():
	anim.play("default")
	await get_tree().create_timer(5.00).timeout

	anim.play("anim")
	await get_tree().create_timer(0.99).timeout

	anim.play("default2")
	await get_tree().create_timer(5.0).timeout

	anim.play("anim2")
	await get_tree().create_timer(0.99).timeout

	loop_animations() 



func _on_area_2d_2_musique_stop() -> void:
	menusound.stream_paused = true
