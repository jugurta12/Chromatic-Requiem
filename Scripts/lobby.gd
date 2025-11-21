@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	loop_animations()

func loop_animations():
	anim.play("anim1")
	await get_tree().create_timer(2.0).timeout

	anim.play("anim2")
	await get_tree().create_timer(2.0).timeout

	anim.play("anim3")
	await get_tree().create_timer(2.0).timeout

	anim.play("anim4")
	await get_tree().create_timer(2.0).timeout

	loop_animations()  # recommence
