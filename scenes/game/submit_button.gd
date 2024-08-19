extends Button

@onready var submit_button_clicked_audio = %SubmitButtonClickedAudio


func _on_pressed():
	submit_button_clicked_audio.play()
