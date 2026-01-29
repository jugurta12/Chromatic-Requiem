extends CanvasLayer
var menu = null

func _ready():
	menu = $TextureRect
	remove_child(menu)  

func _on_pause_pressed() -> void:
	if menu.get_parent() == null:
		add_child(menu) 
		get_tree().paused = true
		
	else:
		remove_child(menu) 
		get_tree().paused = false

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/player.tscn")
	


func _on_character_body_2d_game_over() -> void:
	get_tree().paused = false
	visible = false
	if menu.get_parent() != null:
		remove_child(menu)
