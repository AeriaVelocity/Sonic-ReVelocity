extends ColorRect

@onready var skip_hint = $CanvasLayer/SkipHint

func _ready():
	await($Logo/AnimationPlayer.animation_finished)
	$SAGELogo/AnimationPlayer.play("displaythenfade")
	await($SAGELogo/AnimationPlayer.animation_finished)
	go_to_menu()

func _process(_delta):
	var hint: String
	match Input.get_joy_name(0):
		"XInput Gamepad":
			hint = "Press Menu to skip"
		"PS4 Controller", "PS5 Controller":
			hint = "Press Options to skip"
		"Nintendo Switch Pro Controller":
			hint = "Press + to skip"
		"":
			hint = "Press ENTER to skip"
		_:
			hint = "Press START to skip"
	if DisplayServer.is_touchscreen_available():
		hint = "Touch screen to skip"
	skip_hint.set_text("[center][font_size=48]" + hint + "[/font_size][/center]")
	if Input.is_action_just_pressed("Start"):
		go_to_menu()

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		go_to_menu()

func go_to_menu():
	get_tree().change_scene_to_file("res://title-screen.tscn")
