extends Area2D
@onready var collision = $CollisionShape2D2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_balise_attack_impact() -> void:
	collision.disabled = false
	await get_tree().create_timer(0.1).timeout
	collision.disabled = true
	
	
