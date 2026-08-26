extends RigidBody2D


@export var sweet : int = 0
@export var sour : int = 0
@export var salty : int = 0
@export var umami : int = 0
@export var bitter : int = 0


var max_speed = 500

func _physics_process(_delta: float) -> void:
	pass

# Max speed it can go
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	@warning_ignore("shadowed_global_identifier")
	var len = min(max_speed, state.linear_velocity.length())
	state.linear_velocity = state.linear_velocity.normalized() * len
