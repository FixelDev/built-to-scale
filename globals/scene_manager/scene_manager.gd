extends Node2D

@export var menu_scene: PackedScene
@export var game_scene: PackedScene
@export var game_over_scene: PackedScene

@onready var transition_panel = %TransitionPanel


func load_scene(scene: PackedScene) -> void:
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 1.0, 0.0, 0.7)
	
	await tween.finished
	get_tree().change_scene_to_packed(scene)
	
	tween = get_tree().create_tween()
	tween.tween_method(set_shader_value, 0.0, 1.0, 0.7)

func set_shader_value(value: float) -> void:
	transition_panel.material.set_shader_parameter("circle_size", value)
