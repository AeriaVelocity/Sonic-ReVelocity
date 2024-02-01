extends VideoStreamPlayer

func _ready():
	var window_size = get_viewport_rect().size
	size = window_size
	await(finished)
	get_tree().change_scene_to_file("res://green-hill-simulator.tscn")

func _process(delta):
	pass
