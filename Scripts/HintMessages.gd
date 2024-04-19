extends Area2D

func get_button_image(type: String) -> String:
	var graphics_path: String = "res://Graphics/Info Signs/"
	match type:
		"Left":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + graphics_path + "/ps-dpad-left.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + graphics_path + "dpad-left.png[/img]"
					else:
						return "[img=48x48]" + graphics_path + "left-key.png[/img]"
				_:
					return "[img=48x48]" + graphics_path + "dpad-left.png[/img]"
		"Right":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + graphics_path + "ps-dpad-right.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + graphics_path + "dpad-right.png[/img]"
					else:
						return "[img=48x48]" + graphics_path + "right-key.png[/img]"
				_:
					return "[img=48x48]" + graphics_path + "dpad-right.png[/img]"
		"Down":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + graphics_path + "ps-dpad-down.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + graphics_path + "dpad-down.png[/img]"
					else:
						return "[img=48x48]" + graphics_path + "down-key.png[/img]"
				_:
					return "[img=48x48]" + graphics_path + "dpad-down.png[/img]"
		"Jump":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + graphics_path + "cross-button.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + graphics_path + "a-button.png[/img]"
					else:
						return "[img=48x48]" + graphics_path + "z-key.png[/img]"
				_:
					return "[img=48x48]" + graphics_path + "a-button.png[/img]"
		"Spin":
			match Input.get_joy_name(0):
				"PS4 Controller", "PS5 Controller":
					return "[img=48x48]" + graphics_path + "circle-button.png[/img]"
				"":
					if DisplayServer.is_touchscreen_available():
						return "[img=48x48]" + graphics_path + "b-button.png[/img]"
					else:
						return "[img=48x48]" + graphics_path + "x-key.png[/img]"
				_:
					return "[img=48x48]" + graphics_path + "b-button.png[/img]"
	return type
	
func display_label(body, message: String):
	if body.is_in_group("Player"):
		var hint_message = get_node("/root/Test Level/HeadsUpDisplay/HintMessage")
		hint_message.set_label_text(message, 2.0)

func _hint_1(body):
	display_label(body, "Press " + get_button_image("Left") + " or " + get_button_image("Right") + " to make Sonic run.\nHold a key down to run faster.")

func _hint_2(body):
	display_label(body, "Press " + get_button_image("Jump") + " to make Sonic jump.\nJumping while running up a slope will send him higher.")

func _hint_3(body):
	display_label(body, "Green walls can be wall jumped off of.\nPress " + get_button_image("Jump") + " to Wall Jump.")

func _hint_4(body):
	var sonic: AnimatedSprite2D = get_node("/root/Test Level/SonicPlayer/Sonic/SonicSprite")
	var direction = "Left"
	if sonic.flip_h:
		direction = "Right"
	display_label(body, "Press " + get_button_image("Spin") + " to perform Quick Spin.\nPress " + get_button_image(direction) + " + " + get_button_image("Spin") + " to perform Quick Spin Reversal.")

func _hint_5(body):
	display_label(body, "In the air, press " + get_button_image("Down") + " + " + get_button_image("Spin") + " to perform Quick Spin Down.")
