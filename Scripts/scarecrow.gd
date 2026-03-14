extends CharacterBody2D
@onready var anime = $AnimatedSprite2D
@onready var hurt = $AudioStreamPlayer2D
var life = 2

func _ready() -> void:
	anime.play("default")


func _on_tutobaadie_hitting() -> void:
	anime.play("hit")
	hurt.play()
	await get_tree().create_timer(0.5).timeout
	anime.play("default")
	life -= 1
	if life == 0 : 
		queue_free()
