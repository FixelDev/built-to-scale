class_name PointsManager extends Node2D

@export var perfect_color: Color
@export var good_color: Color
@export var mid_color: Color
@export var bad_color: Color

@onready var points_label = %PointsLabel
@onready var accuracy_label = %AccuracyLabel
@onready var accuracy_label_spawn_points = %AccuracyLabelSpawnPoints
@onready var mid_accuracy_audio = %MidAccuracyAudio
@onready var excelent_accuracy_audio = %ExcelentAccuracyAudio
@onready var bad_accuracy_audio = %BadAccuracyAudio

var accuracy_label_start_scale: Vector2

func _ready() -> void:
	Globals.stats_changed.connect(_on_stats_changed)
	accuracy_label.pivot_offset = Vector2(accuracy_label.size.x / 2, accuracy_label.size.y / 2)
	accuracy_label_start_scale = Vector2(1, 1)
	accuracy_label.scale = Vector2.ZERO
	points_label.pivot_offset.x = points_label.size.x / 2
	points_label.pivot_offset.y = points_label.size.y / 2
	

func _on_player_console_manager_accuracy_calculated(accuracy):
	var points_to_add: int = 0
	var text_to_show: String
	var text_color: Color
	
	if accuracy >= 0.96:
		points_to_add = Globals.max_points
		text_to_show = "Perfect!"
		text_color = perfect_color
		excelent_accuracy_audio.play()
	elif accuracy >= 0.75 and accuracy < 0.97:
		points_to_add = Globals.max_points * accuracy
		text_to_show = ["Great", "Good", "Well done"].pick_random()
		text_color = good_color
		mid_accuracy_audio.play()
	elif accuracy >= 0.55 and accuracy < 0.75:
		points_to_add = Globals.max_points * (accuracy / 2)
		text_to_show = "Ok"
		text_color = mid_color
		mid_accuracy_audio.play()
	else:
		text_to_show = "Too bad!"
		text_color = bad_color
		bad_accuracy_audio.play()
		
	Globals.points += points_to_add
	show_accuracy_text(text_to_show, text_color)
	

func _on_stats_changed(points_difference: int) -> void:
	points_label.text = "Points: " + str(Globals.points)
	
	if points_difference != 0:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(points_label, "scale", Vector2(1.3, 1.3), 0.5).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(points_label, "scale", Vector2(1, 1), 0.5).set_trans(Tween.TRANS_CUBIC)


func show_accuracy_text(text_to_show: String, text_color: Color) -> void:
	var spawn_point: Vector2 = accuracy_label_spawn_points.get_children().pick_random().global_position
	accuracy_label.global_position = spawn_point
	accuracy_label.text = text_to_show
	accuracy_label.rotation = accuracy_label.rotation + randf_range(-0.2, 0.2)
	accuracy_label.modulate = text_color
	
	var tween_time: float = 0.3
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(accuracy_label, "scale", Vector2(accuracy_label_start_scale.x + 0.2, accuracy_label_start_scale.y + 0.2), tween_time).from(Vector2.ZERO).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(accuracy_label, "scale", accuracy_label_start_scale, tween_time).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	
	tween = get_tree().create_tween()
	
	tween.tween_property(accuracy_label, "scale", Vector2(accuracy_label_start_scale.x + 0.2, accuracy_label_start_scale.y + 0.2), tween_time).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(accuracy_label, "scale", Vector2.ZERO, tween_time).set_trans(Tween.TRANS_CUBIC)
