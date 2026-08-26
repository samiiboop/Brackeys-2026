extends Node2D

"""
This defines what the food requires to be complete and scored

perfect: Required ingredients in over or at amount required not required not added
ok!: Required ingredient in in over or at amount required , not at amount required
ehh: Required ingredient in, not required added
bad: No required ingredient in 
"""

# Script vars.
var sweet_required : int = 0
var sour_required : int = 0
var salty_required : int = 0
var umami_required : int = 0
var bitter_required : int = 0

# References
@onready var server_sprite: Sprite2D = $ServerSprite
@onready var deposit_area: Area2D = $DepositArea

func _init(cheese_level) -> void:
	print("IM ALIVE", cheese_level)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func setup_server():
	pass

func deliver_dialog():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
