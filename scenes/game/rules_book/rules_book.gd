extends Control

func _on_begin_button_pressed():
	hide()


func _on_player_card_player_start():
	await get_tree().create_timer(1).timeout
	
	show()
