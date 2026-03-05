extends Node2D
@onready var elevatoranim1 = $AnimatableBody2D2/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_down() -> void:
	elevatoranim1.play("down")
