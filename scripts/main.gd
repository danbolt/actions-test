class_name Main extends Node

var coin_count: int = 0
@onready var coin_count_label: Label = $Gameplay/CoinCountLabel

func get_coins() -> Array[Coin]:
	var result: Array[Coin] = []
	result.assign($Gameplay/Coins.get_children())
	return result
	
func get_coin_count() -> int:
	return $Gameplay/Coins.get_child_count()
	
func get_next_coin_or_null() -> Coin:
	if get_coin_count() <= 0:
		return null
	return $Gameplay/Coins.get_child(0)

func update_coin_text() -> void:
	coin_count_label.text = "Coins: %s" % [coin_count]

func on_player_get_coin() -> void:
	coin_count += 1
	update_coin_text()

func get_player() -> Player:
	return $Gameplay/Player

func _ready() -> void:
	coin_count = 0
	get_player().collected_coin.connect(on_player_get_coin)
	update_coin_text()
	
func _process(_delta: float) -> void:
	assert(coin_count >= 0, "We have a negative coin count of %s" % [ coin_count ])
