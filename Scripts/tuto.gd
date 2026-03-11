extends Node2D
var menu_scene = preload("res://Scenes/player.tscn")
@onready var elevatoranim1 = $AnimatableBody2D2/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_down() -> void:
	elevatoranim1.play("down")


func _on_area_2d_up() -> void:
	elevatoranim1.play("up")


func _on_area_2d_next() -> void:
	get_tree().change_scene_to_file("res://Scenes/player.tscn")
