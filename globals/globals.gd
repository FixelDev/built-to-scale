extends Node

signal stats_changed(points_difference: int)

var max_points: int = 50

var points: int = 0:
	set(value):
		var difference: int = value - points
		points = value
		stats_changed.emit(difference)
		print(value)
	get:
		return points

var api_key: String

var player_name: String


func _ready() -> void:
	var file = FileAccess.open('res://api_key.env', FileAccess.READ)
	api_key = file.get_as_text()
	
	SilentWolf.configure({
		"api_key": self.api_key,
		"game_id": "builttoscale",
		"log_level": 1
	})
	
	
	#SilentWolf.Scores.wipe_leaderboard()
