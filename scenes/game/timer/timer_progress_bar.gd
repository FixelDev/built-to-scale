extends TextureProgressBar

@onready var game_timer = %GameTimer

func _ready() -> void:
	max_value = game_timer.wait_time
	value = game_timer.wait_time
	

func _process(delta) -> void:
	value = game_timer.time_left
