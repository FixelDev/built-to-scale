class_name GameObjectManager extends Node2D

@export var game_object_scenes: Array[PackedScene] = []

@onready var game_object_outline = %GameObjectOutline

var current_game_object: GameObject
var scale_to_match: float

func _ready() -> void:
	spawn_game_object()
	

func spawn_game_object() -> void:
	var game_object_scene: PackedScene = game_object_scenes.pick_random()
	current_game_object = game_object_scene.instantiate()
	add_child(current_game_object)
	
	var min_scale: float
	var max_scale: float
	
	min_scale = current_game_object.min_scale.x
	
	if current_game_object.max_scale.x <= current_game_object.max_scale.y:
		max_scale = current_game_object.max_scale.x
	else:
		max_scale = current_game_object.max_scale.y
		
	scale_to_match = randf_range(min_scale, max_scale)
	game_object_outline.texture = current_game_object.texture
	game_object_outline.scale = Vector2(scale_to_match, scale_to_match)
