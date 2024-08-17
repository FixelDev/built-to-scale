class_name PointsManager extends Node2D

@onready var points_label = %PointsLabel

func _ready() -> void:
	Globals.stats_changed.connect(_on_stats_changed)


func _on_player_console_manager_submit_button_pressed(accuracy):
	var points_to_add: int = 0
	
	if accuracy >= 0.98:
		points_to_add = Globals.max_points
	elif accuracy >= 0.3 and accuracy < 0.98:
		points_to_add = Globals.max_points * accuracy
	
	Globals.points += points_to_add


func _on_stats_changed() -> void:
	points_label.text = "Points: " + str(Globals.points)
