extends TextureRect


var start_scale: Vector2
var is_tween_in_progress: bool = false

func _ready() -> void:
	start_scale = scale


func _process(delta) -> void:
	if is_tween_in_progress:
		return
		
	is_tween_in_progress = true
	
	var tween: Tween = get_tree().create_tween()
	var time: float = randf_range(0.8, 1.2)
	tween.tween_property(self, "scale", Vector2(start_scale.x - 0.3, start_scale.y + 0.3), time).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", start_scale, time).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2(start_scale.x + 0.3, start_scale.y - 0.3), time).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	
	is_tween_in_progress = false
