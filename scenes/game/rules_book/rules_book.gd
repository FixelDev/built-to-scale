extends Control


func _on_start_button_pressed():
	await get_tree().create_timer(1).timeout
	
	show()


func _on_begin_button_pressed():
	hide()
