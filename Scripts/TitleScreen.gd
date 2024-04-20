extends Control

func _ready():
	await($Logo/AnimationPlayer.animation_finished)
	$PressStart/AnimationPlayer.play("blinkingtext")

func _process(_delta):
	var hint: String
	match Input.get_joy_name(0):
		"XInput Gamepad":
			hint = "PRESS MENU BUTTON"
		"PS4 Controller", "PS5 Controller":
			hint = "PRESS OPTIONS BUTTON"
		"Nintendo Switch Pro Controller":
			hint = "PRESS + BUTTON"
		"":
			hint = "PRESS ENTER KEY"
		_:
			hint = "PRESS START BUTTON"
	if DisplayServer.is_touchscreen_available():
		hint = "TOUCH TO START"
	$PressStart.set_text(hint)

const NEXT_SCENE: String = "res://main_menu.tscn"

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		get_tree().change_scene_to_file(NEXT_SCENE)
	if Input.is_action_just_pressed("Start"):
		get_tree().change_scene_to_file(NEXT_SCENE)
