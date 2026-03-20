extends Area2D
@onready var anime = $AnimatedSprite2D
signal go

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anime.visible = false



func _on_body_entered(body: Node2D) -> void:
	if body.name == "tutobaadie" :
		go.emit()
		await get_tree().create_timer(3).timeout
		anime.visible = true
		anime.play("default")
		await get_tree().create_timer(0.3332).timeout
		anime.play("stay")

 
func _on_canvas_layer_end_3() -> void:
	await get_tree().create_timer(0.3332).timeout
	anime.play("bye")
	await get_tree().create_timer(0.3332).timeout
	anime.visible = false
	queue_free()
