class_name PlayerScoreItem extends PanelContainer

@onready var place_label = %PlaceLabel
@onready var player_name_label = %PlayerNameLabel
@onready var player_score_label = %PlayerScoreLabel

func set_info(place: int, player_name: String, score: int) -> void:
	place_label.text = str(place)
	player_name_label.text = player_name
	player_score_label.text = str(score)
