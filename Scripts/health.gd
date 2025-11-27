extends AnimatedSprite2D

@export var player : CharacterBody2D 

func _ready():
	if player:
		update_health_bar(player.health)

func update_health_bar(new_health):
	match new_health:
		100:
			play("100%")
		75:
			play("75%")
		50:
			play("50%")
		25:
			play("25%")
		0:
			play("0%")

func _on_character_body_2d_health_changed(new_health):
	update_health_bar(new_health)
