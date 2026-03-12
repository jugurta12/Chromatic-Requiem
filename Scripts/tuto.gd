extends Node2D
var menu_scene = preload("res://Scenes/player.tscn")
@onready var elevatoranim1 = $AnimatableBody2D2/AnimationPlayer
@onready var fleche = $AnimatedSprite2D2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fleche.visible=false
	$AnimatedSprite2D.modulate = Color(0, 0, 0, 1)
	$tutobaadie/AnimatedSprite2D.modulate = Color(0, 0, 0, 1)
	$Sprite2D.modulate = Color(0, 0, 0, 1)
	$Area2D/doorinteract.modulate = Color(0, 0, 0, 1)
	var tween1 = create_tween()
	var tween2 = create_tween()
	var tween3 = create_tween()
	var tween4 = create_tween()
	
	tween1.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1, 1), 3.0)
	tween2.tween_property($tutobaadie/AnimatedSprite2D, "modulate", Color(1, 1, 1, 1), 3.0)
	tween3.tween_property($Sprite2D, "modulate", Color(1, 1, 1, 1), 3.0)
	tween4.tween_property($Area2D/doorinteract, "modulate", Color(1, 1, 1, 1), 3.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_down() -> void:
	elevatoranim1.play("down")


func _on_area_2d_up() -> void:
	elevatoranim1.play("up")


func _on_area_2d_next() -> void:
	$AnimatedSprite2D.modulate = Color(1, 1, 1, 1)
	$tutobaadie/AnimatedSprite2D.modulate = Color(1, 1, 1, 1)
	$Sprite2D.modulate = Color(1, 1, 1, 1)
	$Area2D/doorinteract.modulate = Color(1, 1, 1, 1)
	var tween1 = create_tween()
	var tween2 = create_tween()
	var tween3 = create_tween()
	var tween4 = create_tween()
	
	tween1.tween_property($AnimatedSprite2D, "modulate", Color(0, 0, 0, 1), 1.0)
	tween2.tween_property($tutobaadie/AnimatedSprite2D, "modulate", Color(0, 0, 0, 1), 1.0)
	tween3.tween_property($Sprite2D, "modulate", Color(0, 0, 0, 1), 1.0)
	tween4.tween_property($Area2D/doorinteract, "modulate", Color(0, 0, 0, 1), 1.0)
	
	# Attendre que l'animation se termine avant de changer de scène
	await tween1.finished
	get_tree().change_scene_to_file("res://Scenes/player.tscn")


func _on_canvas_layer_end_2() -> void:
	await get_tree().create_timer(1.0).timeout
	fleche.visible=true
	fleche.play("default")
	await get_tree().create_timer(1.5).timeout
	fleche.play("stay")
	
