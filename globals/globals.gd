extends Node

signal stats_changed()

var max_points: int = 50

var points: int = 0:
	set(value):
		points = value
		stats_changed.emit()
		print(value)
	get:
		return points

var api_key: String

func _ready() -> void:
	var file = FileAccess.open('res://api_key.env', FileAccess.READ)
	api_key = file.get_as_text()
	
	SilentWolf.configure({
		"api_key": self.api_key,
		"game_id": "Builttoscale12",
		"log_level": 1
 	})
