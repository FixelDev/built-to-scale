class_name PlayerConsoleManager extends Node2D

@onready var game_object_manager = %GameObjectManager
@onready var scale_slider_x = %ScaleSliderX
@onready var scale_slider_y = %ScaleSliderY
@onready var submit_button = %SubmitButton
@onready var timer_progress_bar = %TimerProgressBar
@onready var shift_ended_horn_audio = %ShiftEndedHornAudio
@onready var shift_ended_clock_alarm_audio = %ShiftEndedClockAlarmAudio

signal accuracy_calculated(accuracy: float)

var scaling_factor: Vector2
var accuracy: float
var shift_ended: bool = false

func _process(delta) -> void:	
	if scaling_factor == Vector2.ZERO:
		return
	
	if game_object_manager.current_game_object.scale.x <= game_object_manager.current_game_object.min_scale.x and scaling_factor.x < 0:
		return
	
	if game_object_manager.current_game_object.scale.x >= game_object_manager.current_game_object.max_scale.x and scaling_factor.x > 0:
		return
		
	if game_object_manager.current_game_object.scale.y <= game_object_manager.current_game_object.min_scale.y and scaling_factor.y < 0:
		return
		
	if game_object_manager.current_game_object.scale.y >= game_object_manager.current_game_object.max_scale.y and scaling_factor.y > 0:
		return
	
	game_object_manager.current_game_object.scale += scaling_factor


func calculate_percentage(current_scale: float, scale_to_match: float) -> float:
	var bigger_value: float
	var smaller_value: float
	
	if scale_to_match >= current_scale:
		bigger_value = scale_to_match
		smaller_value = current_scale
	else:
		bigger_value = current_scale
		smaller_value = scale_to_match
		
	return smaller_value / bigger_value

	
func _on_scale_slider_used(scaling_factor: Vector2) -> void:
	self.scaling_factor = scaling_factor


func calculate_accuracy() -> void:
	var current_scale: Vector2 = game_object_manager.current_game_object.scale
	
	var percentage_x: float = calculate_percentage(current_scale.x, game_object_manager.scale_to_match)
	var percentage_y: float = calculate_percentage(current_scale.y, game_object_manager.scale_to_match)
	
	accuracy = (percentage_x + percentage_y) / 2


func _on_game_object_manager_game_object_spawned():
	if shift_ended:
		return
	
	toggle_console_tools(true)
	

func toggle_console_tools(enabled: bool) -> void:
	scale_slider_x.editable = enabled
	scale_slider_y.editable = enabled
	submit_button.disabled = !enabled


func _on_game_object_manager_game_object_destroyed():
	calculate_accuracy()
	accuracy_calculated.emit(accuracy)
	
	await get_tree().create_timer(2).timeout
	
	game_object_manager.spawn_game_object()


func _on_submit_button_pressed():	
	toggle_console_tools(false)


func _on_game_timer_timeout():
	toggle_console_tools(false)
	shift_ended = true
	shift_ended_horn_audio.play()
	
	await get_tree().create_timer(1.5).timeout
	
	shift_ended_clock_alarm_audio.play()
	
	await SilentWolf.Scores.save_score(Globals.player_name, Globals.points).sw_save_score_complete
	
	await shift_ended_clock_alarm_audio.finished
	SceneManager.load_scene(SceneManager.game_over_scene)
	

func _on_begin_button_pressed():
	await get_tree().create_timer(1).timeout
	
	game_object_manager.spawn_game_object()
	timer_progress_bar.start_timer()
