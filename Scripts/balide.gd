extends CharacterBody2D
@onready var anim = $CollisionShape2D/AnimatedSprite2D
@onready var anim_collision = $CollisionShape2D
@onready var anime = $Area2D/atk
@onready var area_collision = $Area2D/CollisionShape2D2
@onready var attack_area = $Area2D
@onready var balise_release = $baliserelease
@onready var balise_blast= $baliseblast
@onready var balise_grow= $balisegrow
var amount = 25
var player_in_attack_zone = false
var player_ref = null
var following_player = false
var lockedY = false
signal dmg(amount)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	anim_collision.disabled = true 
	anim.visible = false  
	anime.visible = false 
	attack_area.body_entered.connect(_on_area_entered)
	attack_area.body_exited.connect(_on_area_exited)
	area_collision.disabled = true
	
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player_ref = players[0]
	await get_tree().create_timer(15).timeout
	anim_collision.disabled = false 
	balise_grow.play()
	anim.play("begin")
	anim.visible = true 
	anime.visible = false  
	await get_tree().create_timer(0.799).timeout
	anim.play("default")
	await get_tree().create_timer(0.33).timeout
	balise_grow.stop()
	
	while true:
		following_player = true
		await get_tree().create_timer(3).timeout
		anim.play("atk")
		await get_tree().create_timer(1.449).timeout
		balise_release.play()
		
		await get_tree().create_timer(1).timeout
		lockedY = true
		await get_tree().create_timer(0.001).timeout
		lockedY = false
		anime.visible = true
		anime.play("target")
		
		area_collision.disabled = false
		await get_tree().process_frame
		
		await get_tree().create_timer(0.332).timeout
		
		anim.play("default")
		await get_tree().create_timer(3).timeout
		following_player = false
		anime.play("atk")
		balise_blast.play()
		
		await get_tree().create_timer(0.37).timeout
		if player_in_attack_zone:
			dmg.emit(amount)
		
		await get_tree().create_timer(0.12).timeout
		
		area_collision.disabled = true
		anime.visible = false
		await get_tree().create_timer(6).timeout

func _process(delta: float) -> void:
	if following_player and player_ref:
		attack_area.global_position.x = player_ref.global_position.x-200
	if lockedY and player_ref:
		attack_area.global_position.y = player_ref.global_position.y

func _on_area_entered(body):
	if body.is_in_group("player"):
		player_in_attack_zone = true
		player_ref = body

func _on_area_exited(body):
	if body.is_in_group("player"):
		player_in_attack_zone = false
