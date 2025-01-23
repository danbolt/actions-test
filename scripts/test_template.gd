class_name TestTemplate extends Node

@onready var main: Main = $Main

func _test_coroutine() -> void:
	assert(false, "_test_coroutine was not overridden")

func _cleanup_function() -> void:
	pass

func _add_test_label() -> void:
	var label: Label = Label.new()
	label.text = "Running test: %s" % [self.name]
	add_child(label)

	
func test_passed() -> void:
	print("Test passed: %s" % [self.name])
	_cleanup_function()
	get_tree().quit(0)
	
func test_failed(reason: String) -> void:
	push_error("Test failed: %s\nReason: %s" % [self.name, reason])
	_cleanup_function()
	get_tree().quit(1)

func _ready() -> void:
	_test_coroutine.call_deferred()
	_add_test_label()
