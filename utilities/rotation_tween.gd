extends Label


var start_rotation: float
var rotation_offset: float = 0.1
var is_tween_in_progress: bool = false


func _ready() -> void:
	start_rotation = rotation
	
	
func _process(delta) -> void:
	if is_tween_in_progress:
		return
		
	is_tween_in_progress = true
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", start_rotation + rotation_offset, 1).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", start_rotation - rotation_offset, 1).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	is_tween_in_progress = false
	
