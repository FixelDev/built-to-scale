class_name GameObjectSpawner extends Node2D

@export var game_object_scenes: Array[PackedScene] = []

@onready var game_object_outline = %GameObjectOutline


func _ready() -> void:
	spawn_game_object()
	

func spawn_game_object() -> void:
	var game_object_scene: PackedScene = game_object_scenes.pick_random()
	var game_object: GameObject = game_object_scene.instantiate()
	add_child(game_object)
	
	var min_scale: float
	var max_scale: float
	
	min_scale = game_object.min_scale.x
	
	if game_object.max_scale.x <= game_object.max_scale.y:
		max_scale = game_object.max_scale.x
	else:
		max_scale = game_object.max_scale.y
		
	var random_scale: float = randf_range(min_scale, max_scale)
	game_object_outline.scale = Vector2(random_scale, random_scale)
