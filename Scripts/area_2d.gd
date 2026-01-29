extends Area2D
var menu_scene = preload("res://Scenes/menu.tscn")


func _on_body_entered(body):
	print("Collision with ", body.name)
	if body.name == "persomenu":
		var menu_instance = menu_scene.instantiate()
		get_tree().current_scene.add_child(menu_instance)
		get_tree().paused = true
		
