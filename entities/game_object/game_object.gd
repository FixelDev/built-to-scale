class_name GameObject extends Sprite2D

@export var max_scale: Vector2 = Vector2(3, 3)
@export var min_scale: Vector2 = Vector2(0.5, 0.5)

var random_strength: float = 6.0
var shake_fade: float = 7.0
var rng = RandomNumberGenerator.new()
var shake_strength: float = 0.0
var shader_progress: float = 0.0

func _ready() -> void:
	material.set_shader_parameter("progress", shader_progress)
	
	var scale_x: float = randf_range(min_scale.x, max_scale.x)
	var scale_y: float = randf_range(min_scale.y, max_scale.y)
	scale = Vector2.ZERO
	
	var tween: Tween = get_tree().create_tween()
	
	tween.tween_property(self, "scale", Vector2(scale_x, scale_y), 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(self, "rotation", 0.05, 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", -0.05, 0.3).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", 0, 0.3).set_trans(Tween.TRANS_CUBIC)


func _process(delta) -> void:
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		shader_progress = lerpf(shader_progress, 1, shake_fade * delta)
		
		material.set_shader_parameter("progress", shader_progress)
		
		offset = random_offset()
		
		if shake_strength < 0.05:
			queue_free()


func destroy() -> void:
	apply_strength()
	

func apply_strength() -> void:
	shake_strength = random_strength


func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
