extends CharacterBody2D
@onready var anim = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("begin")
	await get_tree().create_timer(0.60).timeout
	anim.play("default")
	while true:
		await get_tree().create_timer(3).timeout
		anim.play("atk")
		await get_tree().create_timer(2.832).timeout
		anim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
