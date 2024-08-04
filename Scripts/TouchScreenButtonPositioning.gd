extends Node2D

func _process(_delta):
    var viewport_size = get_viewport_rect().size
    var buttons_height = viewport_size.y - 256

    var left_group = get_node_or_null("Left")
    var right_group = get_node_or_null("Right")
    var pause_button = get_node_or_null("Pause")

    if left_group != null:
        var left_position = Vector2(20, buttons_height)
        left_group.position = left_position

    if right_group != null:
        var right_position = Vector2(viewport_size.x - 60, buttons_height)
        right_group.position = right_position

    if pause_button != null:
        var pause_position = Vector2(viewport_size.x - 480, 96)
        pause_button.position = pause_position
