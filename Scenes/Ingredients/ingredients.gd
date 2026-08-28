extends Node2D

""" 
Handles ingredient dragging behavior
"""

@onready var mouse_pin: PinJoint2D = $MousePin
@onready var static_body_2d: StaticBody2D = $MousePin/StaticBody2D
@onready var marker_2d: Marker2D = $Marker2D

var current_body : RigidBody2D
var is_dragging = false
var deposit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	static_body_2d.mouse_entered.connect(_on_border_entered)
	



	for rb in get_children():
		if rb is RigidBody2D: rb.input_event.connect(_on_input_event.bind(rb))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	mouse_pin.global_position = get_global_mouse_position()
	
	if current_body:
		if deposit and current_body.rotation_degrees < 140:
			current_body.rotation_degrees += 5
		elif not deposit and current_body.rotation_degrees >= 0:
			current_body.rotation_degrees -= 10

func _unhandled_input(event: InputEvent) -> void:
	if is_dragging and event is InputEventMouseButton and not event.is_pressed():
		mouse_pin.node_b = NodePath()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		is_dragging = false
		if current_body: 
			current_body.lock_rotation = false
			current_body = null



func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int, rb : RigidBody2D) -> void:
	if not is_dragging and event is InputEventMouseButton and event.is_pressed():
		current_body = rb
		mouse_pin.node_b = mouse_pin.get_path_to(current_body)
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		is_dragging = true
		current_body.lock_rotation = true


func _on_border_entered():
	mouse_pin.node_b = NodePath()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	is_dragging = false
	if current_body: 
		current_body.lock_rotation = false
		current_body = null

# Recieved from world
# updates valid deposit zones this is just for the rotating
