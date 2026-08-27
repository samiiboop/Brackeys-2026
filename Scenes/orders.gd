extends Node2D

""" Handles creating new orders, expiring them and spawning in new servers"""

## TO DO: Difficulty scaling, creating an order etc etc
const FOOD = preload("uid://cha2c65a22fex")

@onready var server_pos_1: Marker2D = $ServerPos1
@onready var server_pos_2: Marker2D = $ServerPos2
@onready var server_pos_3: Marker2D = $ServerPos3


var server_pos_occupance : Dictionary = {
	server_pos_1 : false,
	server_pos_2 : false,
	server_pos_3: false 
}


# References.
@onready var order_timer: Timer = $OrderTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	order_timer.timeout.connect(_on_order_timer_timeout)
	order_timer.start()

func _on_order_timer_timeout():
	var food_scene = FOOD.instantiate()
	add_child(food_scene)
	# get an unoccupied slot for them to go into
	for slot in server_pos_occupance.keys():
		if server_pos_occupance[slot] == true: return
		print("DO WE HAVE A ", slot)
		food_scene.setup($ServerPos1)
		server_pos_occupance[slot] = true

# Dynamically connected when we spawn in a server in on order timeout
func _on_order_complete():
	pass
