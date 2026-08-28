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

# Dialog stuffs
const MAX_WIDTH = 500

var dialog_string = ""
var amount_string = ""

var letter_index = 0
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2
# Signals
signal text_done
# References
@onready var server_sprite: Sprite2D = $ServerSprite
@onready var deposit_area: Area2D = $DepositArea
@onready var letter_timer: Timer = $LetterTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deposit_area.body_entered.connect(_on_deposit_area_body_entered)
	deposit_area.body_exited.connect(_on_deposit_area_body_exited)

func setup(slot):
	generate_order(slot)
	

func generate_order(slot):
	# Pick a random sprite
	# Based on global difficulty decide how many ingredients it needs
	if Game.difficulty <= 5:
		print("GENERATING ORDER")
		generate_easy(slot)
	else:
		generate_easy(slot)

	

func generate_easy(slot):
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
	
	# MOVE IN
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	if randi_range(1, 100) == 1: tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "global_position", slot.global_position, 5)
	await tween.finished
	display_text()

func display_text():
	rich_text_label.text = dialog_string
	var margin_container = $MarginContainer
	await margin_container.resized
	margin_container.custom_maximum_size.x = min(margin_container.size.x, MAX_WIDTH)
	if margin_container.size.x > MAX_WIDTH:
		rich_text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await margin_container.resized
		margin_container.custom_minimum_size.y = margin_container.size.y
	

	rich_text_label.text = ""
	display_letter()

func display_letter():
	print("Display letter")
	if letter_index >= dialog_string.length():
		return
	print("display letter roblox")
	rich_text_label.text += dialog_string[letter_index]
	letter_index += 1
	
	if letter_index >= dialog_string.length() - 1:
		text_done.emit()
		return
	
	match dialog_string[letter_index]:
		"!", ".", ",", "?":
			letter_timer.start(punctuation_time)
		" ":
			letter_timer.start(space_time)
		_:
			letter_timer.start(letter_time)
			
	

func _on_deposit_area_body_entered(body):
	if body is Ingredient:
		body.body_entered()

func _on_deposit_area_body_exited(body):
	if body is Ingredient:
		body.body_exited()
func _on_letter_timer_timeout() -> void:
	print("displaying letter")
	display_letter()
