extends PanelContainer

@export var player_score_item_scene: PackedScene

@onready var player_score_item_container = %PlayerScoreItemContainer


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	
	var results: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	
	var place: int = 1
	for score in results.scores:
		var player_score_item: PlayerScoreItem = player_score_item_scene.instantiate()
		player_score_item.set_info(place, score.player_name, int(score.score))
		player_score_item_container.add_child(player_score_item)
		
		place += 1
