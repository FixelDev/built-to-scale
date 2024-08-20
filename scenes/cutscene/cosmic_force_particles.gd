extends GPUParticles2D


var can_play: bool = true


func _process(delta):
	if not can_play:
		return
		
	can_play = false
	
	emitting = true
	
	await finished
	await get_tree().create_timer(randf_range(0.5, 1.2)).timeout
	
	can_play = true
