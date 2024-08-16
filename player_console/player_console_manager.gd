class_name PlayerConsoleManager extends Node2D

@export var sprite: Sprite2D

var scaling_factor: Vector2

func _process(delta) -> void:	
	
	sprite.scale += scaling_factor


func _on_scale_slider_used(scaling_factor: Vector2) -> void:
	print(scaling_factor)	
	self.scaling_factor = scaling_factor
	
