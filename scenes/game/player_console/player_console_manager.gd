class_name PlayerConsoleManager extends Node2D

@export var sprite: Sprite2D
@export var sprite_to_match: Sprite2D

var scaling_factor: Vector2
var scale_to_match: Vector2
var current_scale: Vector2
var accuracy: float
	

func _process(delta) -> void:	
	if scaling_factor == Vector2.ZERO:
		return
	
	sprite.scale += scaling_factor


func calculate_percentage(current_scale: float, scale_to_match: float) -> float:
	var bigger_value: float
	var smaller_value: float
	
	if scale_to_match >= current_scale:
		bigger_value = scale_to_match
		smaller_value = current_scale
	else:
		bigger_value = current_scale
		smaller_value = scale_to_match
		
	return (smaller_value / bigger_value) * 100.0

	
func _on_scale_slider_used(scaling_factor: Vector2) -> void:
	self.scaling_factor = scaling_factor


func _on_submit_button_pressed():
	calculate_accuracy()
	print(accuracy)


func calculate_accuracy() -> void:
	current_scale = sprite.scale
	scale_to_match = sprite_to_match.scale
	
	var percentage_x: float = calculate_percentage(current_scale.x, scale_to_match.x)
	var percentage_y: float = calculate_percentage(current_scale.y, scale_to_match.y)
	
	accuracy = (percentage_x + percentage_y) / 2
