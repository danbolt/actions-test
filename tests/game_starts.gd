class_name GameStarts extends TestTemplate

func _test_coroutine() -> void:
	for i in range(20):
		await get_tree().physics_frame
	
	#test_passed()
	test_failed("does this error to the console?")
