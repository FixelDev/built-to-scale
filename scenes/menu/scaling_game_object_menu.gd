extends Control

var can_tween: bool = true
var start_scale: float
var final_scale: float

func _ready() -> void:
	pivot_offset.x = size.x / 2
	pivot_offset.y = size.y / 2

	start_scale = scale.x
	final_scale = start_scale + 0.3
	
	
func _process(delta) -> void:
	if not can_tween:
		return
		
	start_tween()


func start_tween() -> void:
	can_tween = false
	
	var random_time: float = randf_range(0.6, 1)
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(final_scale, final_scale), random_time).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2(start_scale, start_scale), random_time).set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished
	await get_tree().create_timer(1.5).timeout
	
	can_tween = true
