extends Node

func _process(_delta):
    if Input.is_action_just_pressed("FullScreen"):
        toggle_fullscreen()

func toggle_fullscreen():
    var full_screen = DisplayServer.window_get_mode()

    if full_screen:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
    else:
        DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
