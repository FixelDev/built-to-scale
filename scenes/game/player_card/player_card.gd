extends PanelContainer

@onready var player_name = %PlayerName
@onready var player_card_submitted_audio = %PlayerCardSubmittedAudio
@onready var player_card_rejected_audio = %PlayerCardRejectedAudio

signal player_start()

func _ready() -> void:
	show()

func _on_start_button_pressed():
	if player_name.text.length() <= 0:
		player_card_rejected_audio.play()
		return
	
	player_start.emit()
	Globals.player_name = player_name.text
	hide()
	
	player_card_submitted_audio.play()
