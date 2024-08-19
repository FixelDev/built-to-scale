extends PanelContainer

@export var player_score_item_scene: PackedScene

@onready var player_score_item_container = %PlayerScoreItemContainer
@onready var loading_label = %LoadingLabel
@onready var loading_results_audio = %LoadingResultsAudio


func _ready() -> void:
	loading_results_audio.play()
	await get_tree().create_timer(0.5).timeout
	
	var results: Dictionary = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete
	
	var place: int = 1
	for score in results.scores:
		var player_score_item: PlayerScoreItem = player_score_item_scene.instantiate()
		player_score_item.set_info(place, score.player_name, int(score.score))
		player_score_item_container.add_child(player_score_item)
		
		place += 1
	
	await get_tree().create_timer(0.7).timeout
	
	loading_label.visible = false
	player_score_item_container.visible = true
