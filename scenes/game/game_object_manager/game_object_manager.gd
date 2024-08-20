class_name GameObjectManager extends Node2D

@export var game_object_scenes: Array[PackedScene] = []

@onready var game_object_outline = %GameObjectOutline
@onready var game_object_destroy_particles = %GameObjectDestroyParticles
@onready var game_object_spawned_audio = %GameObjectSpawnedAudio
@onready var game_object_powering_up_audio = %GameObjectPoweringUpAudio
@onready var game_timer = %GameTimer

var available_game_object_scene: Array[PackedScene] = []
var current_game_object: GameObject
var scale_to_match: float
var can_spawn_game_object: bool = true

signal game_object_spawned()
signal game_object_destroyed()
	
	
func _ready() -> void:
	available_game_object_scene = game_object_scenes.duplicate()


func spawn_game_object() -> void:
	if not can_spawn_game_object: 
		return
	
	var game_object_scene: PackedScene = available_game_object_scene.pick_random()
	available_game_object_scene.erase(game_object_scene)
	
	if available_game_object_scene.size() <= 0:
		available_game_object_scene = game_object_scenes.duplicate()
	
	current_game_object = game_object_scene.instantiate()
	add_child(current_game_object)
	
	game_object_spawned_audio.play()
	
	var min_scale: float
	var max_scale: float
	
	min_scale = current_game_object.min_scale.x
	
	if current_game_object.max_scale.x <= current_game_object.max_scale.y:
		max_scale = current_game_object.max_scale.x
	else:
		max_scale = current_game_object.max_scale.y
		
	scale_to_match = randf_range(min_scale, max_scale)
	
	
	await get_tree().create_timer(0.7).timeout
	
	game_object_outline.modulate.a = 1
	game_object_outline.texture = current_game_object.texture
	game_object_outline.scale = Vector2(scale_to_match, scale_to_match)
	
	await get_tree().create_timer(get_outline_show_time()).timeout
	game_object_outline.modulate.a = 0
	game_object_spawned.emit()


func get_outline_show_time() -> float:
	var time: float
	
	if game_timer.time_left > 90 and game_timer.time_left <= 120:
		time = 1
	elif game_timer.time_left > 45 and game_timer.time_left <= 90:
		time = 0.7
	else:
		time = 0.3
		
	return time


func _on_submit_button_pressed():
	game_object_outline.modulate.a = 1
	current_game_object.destroy()
	game_object_powering_up_audio.play()
	
	await get_tree().create_timer(0.6).timeout
	game_object_destroy_particles.emitting = true
	game_object_outline.texture = null
	game_object_destroyed.emit()


func _on_game_timer_timeout():
	can_spawn_game_object = false
