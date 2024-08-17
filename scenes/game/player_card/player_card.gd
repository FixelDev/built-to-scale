extends PanelContainer

@onready var player_name = %PlayerName

signal player_start()

func _ready() -> void:
	show()

func _on_start_button_pressed():
	if player_name.text.length() <= 0:
		return
	
	player_start.emit()
	Globals.player_name = player_name.text
	hide()
