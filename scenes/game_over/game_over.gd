extends Node2D

@onready var player_score_label = %PlayerScoreLabel
@onready var button_pressed_audio = %ButtonPressedAudio


func _ready() -> void:
	player_score_label.text = "Your score: " + str(Globals.points)


func _on_try_again_button_pressed():
	button_pressed_audio.play()
	SceneManager.load_scene(SceneManager.game_scene)


func _on_menu_button_pressed():
	button_pressed_audio.play()
	SceneManager.load_scene(SceneManager.menu_scene)
