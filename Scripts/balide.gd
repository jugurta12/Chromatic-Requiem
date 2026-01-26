extends CharacterBody2D
@onready var anim = $CollisionShape2D/AnimatedSprite2D
@onready var anime = $CollisionShape2D2/atk

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("begin")
	anime.visible = false  
	await get_tree().create_timer(0.59).timeout
	anim.play("default")
	while true:
		await get_tree().create_timer(3).timeout
		anim.play("atk")
		await get_tree().create_timer(2.5).timeout
		anime.visible = true
		anime.play("target")
		await get_tree().create_timer(0.332).timeout
		anim.play("default")
		await get_tree().create_timer(3).timeout
		anime.play("atk")
		await get_tree().create_timer(0.49).timeout
		anime.visible = false  
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
