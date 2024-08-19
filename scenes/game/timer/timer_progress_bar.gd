class_name TimerProgressBar extends TextureProgressBar

@onready var game_timer = %GameTimer
@onready var shift_almost_ended_audio = %ShiftAlmostEndedAudio

var is_tween_in_progress: bool = false
var is_timer_in_progress: bool = false

func start_timer() -> void:
	game_timer.start()
	max_value = game_timer.wait_time
	value = game_timer.wait_time
	is_timer_in_progress = true


func _process(delta) -> void:
	if not is_timer_in_progress:
		return
	
	value = game_timer.time_left
	
	if game_timer.time_left <= 15.0 and not is_tween_in_progress:
		start_clock_ticking()
		
		
func start_clock_ticking() -> void:
	is_tween_in_progress = true
	
	shift_almost_ended_audio.play()
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(shift_almost_ended_audio, "volume_db", 7, 15).from(-30)
	

func _on_game_timer_timeout():
	shift_almost_ended_audio.stop()
