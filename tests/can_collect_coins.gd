class_name CanCollectCoins extends TestTemplate

const REASONABLE_TIME_TIMEOUT: float = 60

var has_link: bool = false
var has_leaped: bool = false
var link_start: Vector2
var link_end: Vector2

var timeout: SceneTreeTimer

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		timeout = null

func on_link_reached(details: Dictionary) -> void:
	has_link = true
	has_leaped = false
	link_start = details["link_entry_position"]
	link_end = details["link_exit_position"]
	
func _test_coroutine() -> void:
	var player = main.get_player()
	
	var playerNavAgent := NavigationAgent2D.new()
	player.add_child(playerNavAgent)
	playerNavAgent.link_reached.connect(on_link_reached)
	
	timeout = get_tree().create_timer(REASONABLE_TIME_TIMEOUT, false)
	
	while main.get_coin_count() > 0:
		if timeout != null and timeout.time_left <= 0.0:
			test_failed("Couldn't find all the coins in a reasonable time")
			return
		
		var next_coin: Coin = main.get_next_coin_or_null()
		playerNavAgent.target_position = next_coin.position
		
		var next_path_position: Vector2 = playerNavAgent.get_next_path_position()
		
		if has_link:
			next_path_position = link_end if has_leaped else link_start
			
		if has_link and not has_leaped and player.is_on_floor():
			has_leaped = true  
			Input.action_press("jump")
			
			await get_tree().physics_frame
			await get_tree().physics_frame
			
			Input.action_release("jump")
			
			next_path_position = link_end
			
		if has_leaped and has_link:
			next_path_position = link_end
			
			if player.is_on_floor():
				has_leaped = false
				has_link = false
			
			
		if player.position.x < next_path_position.x:
			Input.action_press("ui_right")
			if Input.is_action_pressed("ui_left"):
				Input.action_release("ui_left")
		else:
			Input.action_press("ui_left")
			if Input.is_action_pressed("ui_right"):
				Input.action_release("ui_right")
				
		if (not Input.is_action_pressed("jump")) and next_path_position.y < player.position.y and player.is_on_floor():
			Input.action_press("jump")
		elif Input.is_action_pressed("jump"):
			Input.action_release("jump")
		
		await get_tree().physics_frame
		
	timeout = null
	test_passed()
