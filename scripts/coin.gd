class_name Coin extends Area2D

@onready var coin_polygon: Node2D = $Polygon2D

func on_player_entered(intruder: Node2D) -> void:
	assert(intruder is Player)
	(intruder as Player).collect_coin()
	queue_free()

func _ready() -> void:
	body_entered.connect(on_player_entered)

func _process(delta: float) -> void:
	coin_polygon.rotate(delta * 10)
