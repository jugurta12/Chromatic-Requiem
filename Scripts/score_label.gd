extends Label
var score = 0
var score_timer: Timer
func _ready():
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
