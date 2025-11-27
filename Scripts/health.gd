extends AnimatedSprite2D

@export var shake_intensity := 5
@export var shake_duration := 0.2

var original_position
var previous_health := 100
var shaking := false

func _ready():
	original_position = position

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
	
	if new_health < previous_health:
		shake()
	previous_health = new_health

func _on_character_body_2d_health_changed(new_health):
	update_health_bar(new_health)

func shake():
	if shaking:
		return
	shaking = true
	var time := 0.0
	while time < shake_duration:
		position = original_position + Vector2(randf_range(-shake_intensity, shake_intensity), randf_range(-shake_intensity, shake_intensity))
		time += get_process_delta_time()
		await get_tree().process_frame
	position = original_position
	shaking = false
