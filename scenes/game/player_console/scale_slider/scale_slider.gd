class_name ScaleSlider extends VSlider


@export var scale_multiplier: Vector2

signal slider_used(scaling_factor: Vector2)

var is_dragging: bool = false


func _ready() -> void:
	slider_used.connect(%PlayerConsoleManager._on_scale_slider_used)


func _process(_delta) -> void:
	if not is_dragging:

		return
	
	slider_used.emit(Vector2(value * scale_multiplier.x, value * scale_multiplier.y))

func _on_drag_started() -> void:
	is_dragging = true


func _on_drag_ended(value_changed) -> void:
	is_dragging = false
	slider_used.emit(Vector2.ZERO)
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "value", 0, 0.3).set_trans(Tween.TRANS_CUBIC)


func _on_mouse_entered():
	pass


func _on_mouse_exited():
	pass
