extends Node2D

@onready var rich_text_label: RichTextLabel = $MarginContainer/MarginContainer/RichTextLabel

"""
This defines what the food requires to be complete and scored

perfect: Required ingredients in over or at amount required not required not added
ok!: Required ingredient in in over or at amount required , not at amount required
ehh: Required ingredient in, not required added
bad: No required ingredient in 
"""

# A list of all possible requirements
var requirements = {
	"sweet" : 0,
	"sour" : 0 ,
	"salty" : 0, 
	"umami" : 0, 
	"bitter" : 0
}
# A list of stuff THIS order requires, we will use this to hold thier values
var order_requirements = {}
var possible_strings = [
	"Customer says there needs to be something %s in the %s please fix so I can go home..."
]
var dialog_string = ""
var amount_string = ""
# References
@onready var server_sprite: Sprite2D = $ServerSprite
@onready var deposit_area: Area2D = $DepositArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

func setup(slot):
	global_position = slot.global_position
	generate_order()
	

func generate_order():
	# Pick a random sprite
	# Based on global difficulty decide how many ingredients it needs
	if Game.difficulty <= 5:
		generate_easy()
	else:
		return

func generate_easy():
	# get a random requirement
	var requirement = requirements.keys().pick_random()
	# generate a random amount
	var amount = randi_range(1, 5)
	# get the amount string for the dialog box
	match amount:
		1:
			amount_string = "a pinch"
		2:
			amount_string = "a little"
		3:
			amount_string = "a decent amount"
		4:
			amount_string = "quite a bit"
		5:
			amount_string = "something really strong"
	order_requirements[requirement] = amount
	dialog_string = possible_strings.pick_random() % [requirement, "chicken"]
	rich_text_label.text = dialog_string

func deliver_dialog():
	pass 
