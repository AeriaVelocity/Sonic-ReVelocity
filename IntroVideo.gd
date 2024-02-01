extends VideoStreamPlayer

func _ready():
	var window_size = get_viewport_rect().size
	size = window_size
	await(finished)
	get_tree().change_scene_to_file("res://green-hill-simulator.tscn")

func _process(delta):
	var skip_hint = $CanvasLayer/SkipHint
	var hint: String
	match Input.get_joy_name(0):
		"XInput Gamepad":
			hint = "Press [color=green]A[/color] to skip"
		"PS4 Controller", "PS5 Controller":
			hint = "Press [img=24]playstation-cross.png[/img] to skip"
		"Nintendo Switch Pro Controller":
			hint = "Press B to skip"
		"":
			hint = "Press SPACE to skip"
		_:
			hint = "Press JUMP to skip"
	skip_hint.set_text("[center][font_size=24]" + hint + "[/font_size][/center]")
	if Input.is_action_just_pressed("Jump"):
		stop()
		get_tree().change_scene_to_file("res://green-hill-simulator.tscn")
