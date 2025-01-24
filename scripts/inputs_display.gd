extends Control

@onready var text: Label = $Text

const ACTIONS_TO_CHECK: Array[String] = [ "jump", "ui_left", "ui_right", "pause"]

func is_pressed_string_maker(val: bool) -> String:
	return "Pressed" if val else "Released"

func _process(_delta: float) -> void:
	text.text = "%s: %s\n%s: %s\n%s: %s\n%s: %s\n" % [
		ACTIONS_TO_CHECK[0], is_pressed_string_maker(Input.is_action_pressed(ACTIONS_TO_CHECK[0])),
		ACTIONS_TO_CHECK[1], is_pressed_string_maker(Input.is_action_pressed(ACTIONS_TO_CHECK[1])),
		ACTIONS_TO_CHECK[2], is_pressed_string_maker(Input.is_action_pressed(ACTIONS_TO_CHECK[2])),
		ACTIONS_TO_CHECK[3], is_pressed_string_maker(Input.is_action_pressed(ACTIONS_TO_CHECK[3])),
	]
