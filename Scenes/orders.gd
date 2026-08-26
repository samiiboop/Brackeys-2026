extends Node2D

""" Handles creating new orders, expiring them and spawning in new servers"""

## TO DO: Difficulty scaling, creating an order etc etc
const FOOD = preload("uid://cha2c65a22fex")

# References.
@onready var order_timer: Timer = $OrderTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#order_timer.timeout.connect()
	pass

func _on_order_timer_timeout():
	pass
