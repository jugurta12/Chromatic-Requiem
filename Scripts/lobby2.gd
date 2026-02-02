extends Node2D

@onready var anim_day : AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_night : AnimatedSprite2D = $AnimatedSprite2D2
@onready var menusound = $menusound

var day = true
var save_path = "user://savegame.cfg"

func _ready():
	load_day_state()
	update_visibility()
	loop_animations_day()
	loop_animations_night()
	menusound.play()

func _on_wait_day() -> void:
	change_time_smoothly()

func change_time_smoothly():
	var tween_in = create_tween()
	tween_in.tween_property(self, "modulate", Color.BLACK, 0.5)
	await tween_in.finished
	
	await get_tree().create_timer(1.0).timeout
	
	day = !day
	save_day_state()
	update_visibility()
	
	var tween_out = create_tween()
	tween_out.tween_property(self, "modulate", Color.WHITE, 0.5)

func update_visibility():
	anim_day.visible = day
	anim_night.visible = !day

func loop_animations_day():
	anim_day.play("default")
	await get_tree().create_timer(5.0).timeout
	anim_day.play("anim")
	await get_tree().create_timer(0.99).timeout
	anim_day.play("default2")
	await get_tree().create_timer(5.0).timeout
	anim_day.play("anim2")
	await get_tree().create_timer(0.99).timeout
	loop_animations_day()

func loop_animations_night():
	anim_night.play("defaultnight")
	await get_tree().create_timer(5.0).timeout
	anim_night.play("animnight")
	await get_tree().create_timer(0.99).timeout
	anim_night.play("default2night")
	await get_tree().create_timer(5.0).timeout
	anim_night.play("anim2night")
	await get_tree().create_timer(0.99).timeout
	loop_animations_night()

func save_day_state():
	var config = ConfigFile.new()
	config.set_value("settings", "is_day", day)
	config.save(save_path)

func load_day_state():
	var config = ConfigFile.new()
	if config.load(save_path) == OK:
		day = config.get_value("settings", "is_day", true)
