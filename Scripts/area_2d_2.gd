extends Area2D
signal musique_stop
var menu_scene = preload("res://Scenes/menu_2.tscn")
var menu_instance = null


func _on_body_entered(body):
	print("Collision with ", body.name)
	if body.name == "persomenu":
		menu_instance = menu_scene.instantiate()
		get_tree().current_scene.add_child(menu_instance)
		get_tree().paused = true
		emit_signal("musique_stop")
