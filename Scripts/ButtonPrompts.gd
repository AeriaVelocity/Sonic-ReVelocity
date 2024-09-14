extends AnimatedSprite2D

func _process(_delta):
    var button_prompts = "default"
    match ControllerHandling.get_real_joy_name():
        "PS4 Controller", "PS5 Controller":
            button_prompts = "playstation"
        "Nintendo Switch Pro Controller":
            button_prompts = "nintendo"
        "XInput Gamepad", "Xbox 360 Controller", "Xbox One Controller", "Xbox Series Controller":
            button_prompts = "xbox"
        "":
            if DisplayServer.is_touchscreen_available():
                # The touch prompts use A and B like an Xbox controller,
                # so use the default prompts.
                button_prompts = "xbox"
            else: # the user is likely using a keyboard
                button_prompts = "keyboard"
        _:
            button_prompts = "default"
    play(button_prompts)
