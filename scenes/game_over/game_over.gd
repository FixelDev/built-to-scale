extends Node2D


func _on_try_again_button_pressed():
	SceneManager.load_scene(SceneManager.game_scene)


func _on_menu_button_pressed():
	SceneManager.load_scene(SceneManager.menu_scene)
