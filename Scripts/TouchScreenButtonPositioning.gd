extends Node2D

func _process(_delta):
	var viewport_size = get_viewport_rect().size
	var buttons_height = viewport_size.y - 256

	var left_position = Vector2(20, buttons_height)
	$Left.position = left_position

	var right_position = Vector2(viewport_size.x - 150, buttons_height)
	$Right.position = right_position
