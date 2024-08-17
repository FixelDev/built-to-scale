extends PanelContainer

@onready var player_name = %PlayerName


func _on_start_button_pressed():
	if player_name.text.length() <= 0:
		return
		
	Globals.player_name = player_name.text
	hide()
