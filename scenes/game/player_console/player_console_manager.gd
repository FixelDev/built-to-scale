class_name PlayerConsoleManager extends Node2D

@onready var game_object_manager = %GameObjectManager

signal submit_button_pressed(accuracy: float)

var scaling_factor: Vector2
var accuracy: float
	

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


func _on_submit_button_pressed():
	calculate_accuracy()
	submit_button_pressed.emit(accuracy)
	print(accuracy)

func calculate_accuracy() -> void:
	var current_scale: Vector2 = game_object_manager.current_game_object.scale
	
	var percentage_x: float = calculate_percentage(current_scale.x, game_object_manager.scale_to_match)
	var percentage_y: float = calculate_percentage(current_scale.y, game_object_manager.scale_to_match)
	
	accuracy = (percentage_x + percentage_y) / 2
