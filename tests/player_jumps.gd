class_name PlayerJumps extends TestTemplate

const MAX_FALL_TIME_SECONDS: float = 5.0

func _test_coroutine() -> void:
	var player_fall_time_limit: SceneTreeTimer = get_tree().create_timer(MAX_FALL_TIME_SECONDS, false)
	
	# Wait until the player is on the floor
	while (true):
		await get_tree().physics_frame
		if main.get_player().is_on_floor():
			break
		if player_fall_time_limit.time_left <= 0.0:
			test_failed("Player never fell to the ground within %s" % [ MAX_FALL_TIME_SECONDS ])
			return
	
	# Make the player jump
	Input.action_press("ui_accept")
	
	# Wait two frames
	await get_tree().physics_frame
	
	Input.action_release("ui_accept")
	await get_tree().physics_frame
	
	if main.get_player().velocity.y >= 0.0:
		test_failed("We pressed jump but the player's velocity is %s" % [ main.get_player().velocity.y ])
		return
	
	# Wait until the player is on the floor again
	while (true):
		await get_tree().physics_frame
		if main.get_player().is_on_floor():
			break
		if player_fall_time_limit.time_left <= 0.0:
			test_failed("Player never fell back down to the ground within %s" % [ MAX_FALL_TIME_SECONDS ])
			return
	
	test_passed()
	
