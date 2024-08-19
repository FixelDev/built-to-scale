extends Control

@onready var rules_book_showed_audio = $RulesBookShowedAudio

func _on_begin_button_pressed():
	hide()
	rules_book_showed_audio.play()

func _on_player_card_player_start():
	await get_tree().create_timer(1).timeout
	
	show()
	rules_book_showed_audio.play()
