extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	anchor_top = 1
	anchor_bottom = 1
	# Adjust margins if necessary
	offset_top = -120  # 50 pixels from the bottom of the screen
	offset_bottom = 0  # At the bottom of the screen
	offset_left = 40

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
