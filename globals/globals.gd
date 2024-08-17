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
