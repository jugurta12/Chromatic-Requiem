extends CanvasLayer

func _ready():
	$ColorRect.modulate = Color(1, 1, 1, 0.3)
	$AnimatedSprite2D.play("default") 
	$quit.visible = true
	$retry.visible = true
	get_tree().paused = true

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/arcade.tscn")
	get_tree().paused = false
	queue_free()
	return


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/player.tscn")
	get_tree().paused = false
	queue_free()
	return
