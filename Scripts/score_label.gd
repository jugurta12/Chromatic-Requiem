extends Label
var score = 0
var highscore = 0
var score_timer: Timer
var save_path = "user://highscore.save"

func _ready():
	load_highscore()
	
	await get_tree().create_timer(3.0).timeout
	score_timer = Timer.new()
	score_timer.wait_time = 1.0
	score_timer.timeout.connect(_on_timer_timeout)
	add_child(score_timer)
	score_timer.start()
	text = "Score: %s" % score
func _on_timer_timeout():
	score += 1
	text = "Score: %s" % score
func _on_ennemis_kill() -> void:
	score += 15  
	text = "Score: %s" % score


func save_highscore():
	if score > highscore:
		highscore = score
		var file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_var(highscore)
		file.close()
		
func load_highscore():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		highscore = file.get_var()
		file.close()
	else:
		highscore = 0


func _on_character_body_2d_game_over() -> void:
	if score_timer:
		score_timer.stop()
	save_highscore()
