class_name StochasticInputs extends TestTemplate

const inputs_to_try: Array[String] = [ "jump", "ui_left", "ui_right" ]


const NUMBER_OF_PRESSES: int = 100
var remaining: int = 0

func random_input_hold(input: String, wait_till_on: float, press_time: float) -> void:
	await get_tree().create_timer(wait_till_on).timeout
	Input.action_press(input)
	await get_tree().create_timer(press_time).timeout
	if Input.is_action_pressed(input):
		Input.action_release(input)
		
	remaining -= 1
	if remaining == 0:
		test_passed()

func _test_coroutine() -> void:
	remaining = NUMBER_OF_PRESSES
	for i in range(NUMBER_OF_PRESSES):
		random_input_hold.call_deferred(inputs_to_try[randi_range(0, inputs_to_try.size() - 1)], randf_range(0.1, 8.0), randf_range(0.1, 1.0))
