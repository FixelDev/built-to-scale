class_name PlayerScoreItem extends PanelContainer


func set_info(place: int, player_name: String, score: int) -> void:
	%PlaceLabel.text = "#" + str(place)
	%PlayerNameLabel.text = player_name
	%PlayerScoreLabel.text = str(score)
