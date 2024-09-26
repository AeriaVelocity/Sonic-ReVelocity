extends Node2D

func set_controls_visibility(group: Node2D, touch_only: bool):
    for child in group.get_children():
        if child is TouchScreenButton:
            child.visibility_mode = 1 if touch_only else 0

func _process(_delta):
    var viewport_size = get_viewport_rect().size
    var buttons_height = viewport_size.y - 256

    var left_group = get_node_or_null("Left")
    var right_group = get_node_or_null("Right")
    var pause_button = get_node_or_null("Pause")

    if left_group != null:
        left_group.visible = GameOptions.touch_controls != GameOptions.TouchControls.Never
        var left_position = Vector2(20, buttons_height)
        left_group.position = left_position
        var touch_control_visible = GameOptions.touch_controls
        match touch_control_visible:
            GameOptions.TouchControls.TouchOnly:
                set_controls_visibility(left_group, true)
            GameOptions.TouchControls.Always:
                set_controls_visibility(left_group, false)

    if right_group != null:
        right_group.visible = GameOptions.touch_controls != GameOptions.TouchControls.Never
        var right_position = Vector2(viewport_size.x - 60, buttons_height)
        right_group.position = right_position
        var touch_control_visible = GameOptions.touch_controls
        match touch_control_visible:
            GameOptions.TouchControls.TouchOnly:
                set_controls_visibility(right_group, true)
            GameOptions.TouchControls.Always:
                set_controls_visibility(right_group, false)

    if pause_button != null:
        pause_button.visible = GameOptions.touch_controls != GameOptions.TouchControls.Never
        var pause_position = Vector2(viewport_size.x - 480, 96)
        pause_button.position = pause_position
        var touch_control_visible = GameOptions.touch_controls
        match touch_control_visible:
            GameOptions.TouchControls.TouchOnly:
                pause_button.visibility_mode = 1
            GameOptions.TouchControls.Always:
                pause_button.visibility_mode = 0
