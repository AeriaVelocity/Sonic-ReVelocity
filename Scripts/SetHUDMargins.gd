extends VBoxContainer

@onready var score = $ScoreMargin
@onready var time = $TimeMargin
@onready var rings = $RingsMargin
@onready var speed = $SpeedMargin

## The base spacing between the left edge of the VBoxContainer
## and each MarginContainer HUD element.
@export_range(0, 32) var edge_spacing: int = 16

## The spacing between each HUD element.
@export_range(-8, 16) var element_spacing: int = 0

func _process(_delta):
	score.add_theme_constant_override("margin_left", edge_spacing * 3)
	time.add_theme_constant_override("margin_left", edge_spacing * 2)
	rings.add_theme_constant_override("margin_left", edge_spacing * 1)
	speed.add_theme_constant_override("margin_left", edge_spacing * 0)

	add_theme_constant_override("separation", element_spacing)
