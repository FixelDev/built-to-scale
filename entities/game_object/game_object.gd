class_name GameObject extends Sprite2D

@export var max_scale: Vector2 = Vector2(3, 3)
@export var min_scale: Vector2 = Vector2(0.5, 0.5)


func _ready() -> void:
	var scale_x: float = randf_range(min_scale.x, max_scale.x)
	var scale_y: float = randf_range(min_scale.y, max_scale.y)
	
	scale = Vector2(scale_x, scale_y)
