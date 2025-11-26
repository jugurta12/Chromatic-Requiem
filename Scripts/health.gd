extends AnimatedSprite2D

@export var player : CharacterBody2D 


func update_health_bar(): 
	match player.health:
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
