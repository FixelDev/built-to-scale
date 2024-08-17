extends Node2D

@export var menu_scene: PackedScene
@export var game_scene: PackedScene
@export var game_over_scene: PackedScene


func change_scene(scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)
