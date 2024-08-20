extends Label

var full_text: String


func _ready() -> void:
	full_text = text
	text = ""
	
	for character in full_text:
		await get_tree().create_timer(0.05).timeout
		text += character
