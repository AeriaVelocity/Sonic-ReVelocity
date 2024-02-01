extends VideoStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var window_size = get_viewport_rect().size
	size = window_size
	await(finished)
	get_tree().change_scene_to_file("res://green-hill-simulator.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
