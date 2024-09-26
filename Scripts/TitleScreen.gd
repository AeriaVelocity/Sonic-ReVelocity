extends Control

func _ready():
    await($Logo/AnimationPlayer.animation_finished)
    $PressStart/AnimationPlayer.play("blinkingtext")

func _process(_delta):
    var hint: String
    if GameOptions.button_prompts == GameOptions.Buttons.Automatic:
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
    else:
        match GameOptions.button_prompts:
            GameOptions.Buttons.Xbox:
                hint = "PRESS MENU BUTTON"
            GameOptions.Buttons.PlayStation:
                hint = "PRESS OPTIONS BUTTON"
            GameOptions.Buttons.Switch:
                hint = "PRESS + BUTTON"
            GameOptions.Buttons.Keyboard:
                hint = "PRESS ENTER KEY"
            _: # Positional or default
                hint = "PRESS START BUTTON"
    $PressStart.set_text(hint)

const NEXT_SCENE: String = "res://Scenes/main_menu.tscn"

func _input(event):
    if event is InputEventScreenTouch and event.pressed:
        get_tree().change_scene_to_file(NEXT_SCENE)
    if Input.is_action_just_pressed("Start"):
        get_tree().change_scene_to_file(NEXT_SCENE)
