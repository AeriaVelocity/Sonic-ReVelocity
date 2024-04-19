extends AnimatedSprite2D

func _process(delta):
	var button_prompts = "default"
	match Input.get_joy_name(0):
		"PS4 Controller", "PS5 Controller":
			button_prompts = "playstation"
		"":
			if DisplayServer.is_touchscreen_available():
				# The touch prompts use A and B like an Xbox controller,
				# so use the default prompts.
				button_prompts = "default"
			else: # the user is likely using a keyboard
				button_prompts = "keyboard"
		_:
			button_prompts = "default"
	play(button_prompts)
