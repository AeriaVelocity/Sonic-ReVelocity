extends Area2D

const GRAPHICS_PATH = "res://Graphics/Info Signs/"

func get_button_image(type: String) -> String:
	# Yes, it's horribly inefficient, but frick off
	match type:
		"Left":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + GRAPHICS_PATH + "ps-dpad-left.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + GRAPHICS_PATH + "dpad-left.png[/img]"
					else:
						return "[img=48x48]" + GRAPHICS_PATH + "kbd-left.png[/img]"
				_:
					return "[img=48x48]" + GRAPHICS_PATH + "dpad-left.png[/img]"
		"Right":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + GRAPHICS_PATH + "ps-dpad-right.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + GRAPHICS_PATH + "dpad-right.png[/img]"
					else:
						return "[img=48x48]" + GRAPHICS_PATH + "kbd-right.png[/img]"
				_:
					return "[img=48x48]" + GRAPHICS_PATH + "dpad-right.png[/img]"
		"DLeft":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + GRAPHICS_PATH + "ps-dpad-dleft.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + GRAPHICS_PATH + "dpad-dleft.png[/img]"
					else:
						return "[img=48x48]" + GRAPHICS_PATH + "kbd-left.png[/img]"
				_:
					return "[img=48x48]" + GRAPHICS_PATH + "dpad-dleft.png[/img]"
		"DRight":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + GRAPHICS_PATH + "ps-dpad-dright.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + GRAPHICS_PATH + "dpad-dright.png[/img]"
					else:
						return "[img=48x48]" + GRAPHICS_PATH + "kbd-right.png[/img]"
				_:
					return "[img=48x48]" + GRAPHICS_PATH + "dpad-dright.png[/img]"
		"Down":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + GRAPHICS_PATH + "ps-dpad-down.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + GRAPHICS_PATH + "dpad-down.png[/img]"
					else:
						return "[img=48x48]" + GRAPHICS_PATH + "kbd-down.png[/img]"
				_:
					return "[img=48x48]" + GRAPHICS_PATH + "dpad-down.png[/img]"
		"Jump":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + GRAPHICS_PATH + "cross-button.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + GRAPHICS_PATH + "a-button.png[/img]"
					else:
						return "[img=48x48]" + GRAPHICS_PATH + "z-key.png[/img]"
				_:
					return "[img=48x48]" + GRAPHICS_PATH + "a-button.png[/img]"
		"Spin":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + GRAPHICS_PATH + "circle-button.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + GRAPHICS_PATH + "b-button.png[/img]"
					else:
						return "[img=48x48]" + GRAPHICS_PATH + "x-key.png[/img]"
				_:
					return "[img=48x48]" + GRAPHICS_PATH + "b-button.png[/img]"
	return type

func display_label(body, message: String):
	if body.is_in_group("Player"):
		var hint_message = get_node("/root/Test Level/HeadsUpDisplay/HintMessage")
		hint_message.set_label_text(message, 2.0)

func _hint_1(body):
	var sonic: AnimatedSprite2D = get_node("/root/Test Level/SonicPlayer/Sonic/SonicSprite")
	var direction = "Left" if sonic.flip_h else "Right"
	display_label(body, "Press " + get_button_image(direction) + " to make Sonic run.\nContinue holding " + get_button_image(direction) + " down to build up speed.")

func _hint_2(body):
	display_label(body, "Press " + get_button_image("Jump") + " to make Sonic jump.\nJumping while running up a slope will send him higher.")

func _hint_3(body):
	display_label(body, "Green walls can be wall jumped off of.\nPress " + get_button_image("Jump") + " to Wall Jump.")

func _hint_4(body):
	var sonic: AnimatedSprite2D = get_node("/root/Test Level/SonicPlayer/Sonic/SonicSprite")
	var direction = "Right" if sonic.flip_h else "Left"
	display_label(body, "Press " + get_button_image("Spin") + " to perform Quick Spin.\nPress " + get_button_image(direction) + " + " + get_button_image("Spin") + " to perform Quick Spin Reversal.")

func _hint_5(body):
	display_label(body, "In the air, press " + get_button_image("Down") + " + " + get_button_image("Spin") + " to perform Quick Spin Down.")

func _hint_6(body):
	if Input.get_joy_name(0) == "" and not DisplayServer.is_touchscreen_available():
		display_label(body, "In the air, while holding " + get_button_image("Down") + ", press " + get_button_image("Left") + "/" + get_button_image("Right") + " + " + get_button_image("Spin") + " to perform Quick Spin Comet.")
	else:
		display_label(body, "In the air, press " + get_button_image("DLeft") + "/" + get_button_image("DRight") + " + " + get_button_image("Spin") + " to perform Quick Spin Comet.")
