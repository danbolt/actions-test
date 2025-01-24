class_name PauseOnoff extends TestTemplate

func _test_coroutine() -> void:
	test_failed("Uhhh I wasn't feeling it today")
	return
	
	await get_tree().process_frame
	await get_tree().process_frame
	Input.action_press("pause")
	await get_tree().process_frame
	Input.action_release("pause")
	await get_tree().create_timer(1.0, true).timeout
	if not get_tree().paused:
		test_failed("Did not pause when pause was pressed")
		
	await get_tree().process_frame
	Input.action_press("pause")
	Input.action_release("pause")
	await get_tree().create_timer(1.0, true).timeout
	if get_tree().paused:
		test_failed("Did not unpause when pause was pressed")
		
	test_passed()
