extends RigidBody2D
class_name Ingredient

@export var sweet : int = 0
@export var sour : int = 0
@export var salty : int = 0
@export var umami : int = 0
@export var bitter : int = 0


var max_speed = 500
@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(_delta: float) -> void:
	pass

# Max speed it can go
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	@warning_ignore("shadowed_global_identifier")
	var len = min(max_speed, state.linear_velocity.length())
	state.linear_velocity = state.linear_velocity.normalized() * len

func body_entered():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property(sprite_2d,"rotation_degrees", 145, 0.2)



func body_exited():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(sprite_2d,"rotation_degrees", 0, 0.2)
