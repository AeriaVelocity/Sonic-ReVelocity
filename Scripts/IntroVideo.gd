extends ColorRect

@onready var skip_hint = $CanvasLayer/SkipHint

func _ready():
    $SubBackground/AnimationPlayer.play("AeriaVelocity")
    await($Logo/AnimationPlayer.animation_finished)
    $SubBackground/AnimationPlayer.play("Controllers")
    $ControllerHint/AnimationPlayer.play("displaythenfade")
    await($ControllerHint/AnimationPlayer.animation_finished)
    go_to_menu()

func _process(_delta):
    var hint: String
    match ControllerHandling.get_real_joy_name():
        "Xbox 360 Controller", "Xbox One Controller", "XInput Gamepad":
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
    get_tree().change_scene_to_file("res://Scenes/title-screen.tscn")
