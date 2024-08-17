extends PanelContainer

@export var player_score_item_scene: PackedScene

@onready var player_score_item_container = %PlayerScoreItemContainer


func _ready() -> void:
	var results: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	
	var place: int = 1
	for result in results:
		print(result.player_name, str(int(result.score)))
		#var player_score_item: PlayerScoreItem = player_score_item_scene.instantiate()
		#player_score_item.set_info(place, result.player_name, int(result.score))
		#player_score_item_container.add_child(player_score_item)
		#
		#place += 1
