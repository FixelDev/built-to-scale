extends Label

@export var rotation_offset: float = 0.1
@export var rotation_time: float = 1

var start_rotation: float
var is_tween_in_progress: bool = false


func _ready() -> void:
	start_rotation = rotation
	
	
func _process(delta) -> void:
	if is_tween_in_progress:
		return
		
	is_tween_in_progress = true
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", start_rotation + rotation_offset, rotation_time).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", start_rotation - rotation_offset, rotation_time).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	is_tween_in_progress = false
	
