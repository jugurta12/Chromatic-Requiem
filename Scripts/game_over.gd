extends CanvasLayer

func _ready():
	$AnimatedSprite2D.play("transi") 
	await get_tree().create_timer(1.9).timeout
	$AnimatedSprite2D.play("default") 
	$quit.visible = true
	$retry.visible = true
	get_tree().paused = true

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/arcade.tscn")
	get_tree().paused = false
	queue_free()
	return
	
func _on_retry_mouse_entered() -> void:
	$AnimatedSprite2D.play("retry")
	
func _on_retry_mouse_exited() -> void:
	$AnimatedSprite2D.play("default")


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/player.tscn")
	get_tree().paused = false
	queue_free()
	return


func _on_quit_mouse_entered() -> void:
	$AnimatedSprite2D.play("quit")


func _on_quit_mouse_exited() -> void:
	$AnimatedSprite2D.play("default")
