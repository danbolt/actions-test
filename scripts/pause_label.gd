class_name PauseLabel extends Label

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible_characters = 0
	
func _process(_delta: float) -> void:
	var previous_state: bool = visible
	visible = get_tree().paused
	if visible != previous_state:
		if visible == false:
			visible_characters = 0
		else:
			var t = create_tween()
			t.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
			t.tween_property(self, "visible_characters", 5, 0.3)
