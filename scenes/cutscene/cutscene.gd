extends Node2D


func _input(event) -> void:
	if event.is_action_pressed("skip_cutscene"):
		SceneManager.load_scene(SceneManager.game_scene)
