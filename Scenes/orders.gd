extends Node2D

""" Handles creating new orders, expiring them and spawning in new servers"""


## TO DO: Difficulty scaling, creating an order etc etc
const FOOD = preload("uid://cha2c65a22fex")

var server_pos_occupance : Dictionary = {
	"ServerPos1": false,
	"ServerPos2": false,
	"ServerPos3": false 
}


# References.
@onready var order_timer: Timer = $OrderTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	order_timer.timeout.connect(_on_order_timer_timeout)
	order_timer.start()

func _on_order_timer_timeout():
	# get an unoccupied slot for them to go into
	for slot in server_pos_occupance.keys():
		if server_pos_occupance[slot] == true: return
		print("DO WE HAVE A ", slot)
		var food_scene = FOOD.instantiate()
		add_child(food_scene)
		food_scene.global_position = $ServerSpawn.global_position
		food_scene.setup(get_node(slot))
		server_pos_occupance[slot] = true
		
		return
	order_timer.start(5)

# Dynamically connected when we spawn in a server in on order timeout
func _on_order_complete():
	pass 
