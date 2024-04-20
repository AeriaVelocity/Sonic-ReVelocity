extends RichTextLabel

const GRAPHICS_PATH = "res://Graphics/Info Signs/"

func up_button() -> String:
	match Input.get_joy_name(0):
		"PS4 Controller", "PS5 Controller":
			return "[img=48x48]" + GRAPHICS_PATH + "ps-dpad-up.png[/img]"
		"":
			if DisplayServer.is_touchscreen_available():
				return "[img=48x48]" + GRAPHICS_PATH + "dpad-up.png[/img]"
			else:
				return "[img=48x48]" + GRAPHICS_PATH + "kbd-up.png[/img]"
		_:
			return "[img=48x48]" + GRAPHICS_PATH + "dpad-up.png[/img]"

func down_button() -> String:
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

func jump_button() -> String:
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

func spin_button() -> String:
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

func _process(_delta):
	text = text.format({"Up": up_button(), "Down": down_button(), "Jump": jump_button(), "Spin": spin_button()})
