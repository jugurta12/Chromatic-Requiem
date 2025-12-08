extends Node2D

# Variables pour le spawneur
@export var enemy_scene: PackedScene
@export var spawn_interval: float = 3.0
@export var max_enemies: int = 10

var current_enemies: int = 0
var spawn_timer: Timer
var path_follow: PathFollow2D

func _ready():
	$CharacterBody2D.set_physics_process(false)
	$ennemis.set_physics_process(false)
	$AnimatedSprite2D2.visible = false
	$AnimatedSprite2D.play("default")
	modulate = Color(0, 0, 0, 1)
	
	# Référence au MobPath existant
	var mob_path = get_node("mobpath")
	
	if mob_path:
		path_follow = PathFollow2D.new()
		mob_path.add_child(path_follow)
	
	# Création du timer de spawn
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)
	
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 1.0)
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D2.visible = true
	$AnimatedSprite2D2.play("default")
	await get_tree().create_timer(2.7).timeout
	$AnimatedSprite2D2.visible = false
	$CharacterBody2D.set_physics_process(true)
	$ennemis.set_physics_process(true)
	
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	# Vérifie que le joueur existe avant de spawner
	if is_instance_valid($CharacterBody2D) and current_enemies < max_enemies:
		spawn_enemy()

func spawn_enemy() -> void:
	if enemy_scene == null:
		push_error("Aucune scène d'ennemi assignée au spawneur!")
		return
	
	if path_follow == null:
		push_error("PathFollow2D non initialisé!")
		return
	
	path_follow.progress_ratio = randf()
	
	var enemy = enemy_scene.instantiate()
	enemy.global_position = path_follow.global_position
	
	# Connexion des signaux de l'ennemi
	if enemy.has_signal("enemy_died"):
		enemy.enemy_died.connect(_on_enemy_died)
	
	if enemy.has_signal("dmg"):
		enemy.dmg.connect($CharacterBody2D._on_ennemis_dmg)
	
	add_child(enemy)
	current_enemies += 1

func _on_enemy_died() -> void:
	current_enemies -= 1

func _on_attack_timer_timeout() -> void:
	pass
