extends Control

var selected_option_index: int

var tooltip: Label

"""
Current options in the menu:

Full Screen (checkbox)
Camera Smoothing (checkbox)
Camera Smoothing Amount (spinbox: 1 to 100)
FPS Cap (dropdown: 30 FPS, 60 FPS, 120 FPS, Uncapped)
Button Prompts (dropdown: Automatic, Xbox, PlayStation, Switch Pro, Positional, Keyboard)
"""

@onready var music: AudioStreamPlayer = get_node("/root/GlobalAudio/GlobalMusic")

@onready var full_screen_control = $Options/FullScreen
@onready var camera_smoothing_control = $Options/CameraSmoothing
@onready var camera_smoothing_amount_control = $Options/CamSmoothAmount/SpinBox
@onready var fps_cap_control = $Options/FPSCap/OptionButton
@onready var button_prompts_control = $Options/ButtonPrompts/OptionButton

func _ready():
    tooltip = $Tooltip
    handle_tooltip()

    var music_stream: AudioStreamMP3 = load("res://Music/options.mp3")
    music.stream = music_stream
    music.play()

    selected_option_index = 0

    full_screen_control.set_pressed_no_signal(GameOptions.full_screen)
    camera_smoothing_control.set_pressed_no_signal(GameOptions.camera_smoothing)
    camera_smoothing_amount_control.set_value_no_signal(GameOptions.camera_smoothing_amount)
    fps_cap_control.selected = GameOptions.fps_cap
    button_prompts_control.selected = GameOptions.button_prompts

    full_screen_control.connect("toggled", _on_option_toggled)
    camera_smoothing_control.connect("toggled", _on_option_toggled)
    camera_smoothing_amount_control.connect("value_changed", _on_opt_value_changed)
    fps_cap_control.connect("item_selected", _on_opt_item_selected)
    button_prompts_control.connect("item_selected", _on_opt_item_selected)

func _input(_event):
    if Input.is_action_just_pressed("Jump"):
        if GameOptions.button_prompts == GameOptions.Buttons.Switch:
            get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
    elif Input.is_action_just_pressed("Spin"):
        if GameOptions.button_prompts != GameOptions.Buttons.Switch:
            get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_option_toggled(t: bool):
    apply_options("Value: %s" % "on" if t else "off")

func _on_opt_value_changed(v: float):
    apply_options("Value: %f" % v)

func _on_opt_item_selected(x: int):
    var i: int = fps_cap_control.get_item_id(x)
    apply_options("Index: %d\nID: %d" % [x, i])

func apply_options(message: String = ""):
    print(message)
    GameOptions.full_screen = full_screen_control.button_pressed
    GameOptions.camera_smoothing = camera_smoothing_control.button_pressed
    GameOptions.camera_smoothing_amount = camera_smoothing_amount_control.value
    GameOptions.fps_cap = fps_cap_control.get_selected_id()
    GameOptions.button_prompts = button_prompts_control.get_selected_id()
    GameOptions.set_config()

func handle_tooltip():
    tooltip.text = "Configure options and settings."

func _full_screen_tooltip():
    tooltip.text = "Toggle full screen mode."

func _camera_smoothing_tooltip():
    tooltip.text = "Toggle camera position smoothing."

func _smoothing_amount_tooltip():
    tooltip.text = "Set the camera position smoothing factor."

func _fps_cap_tooltip():
    tooltip.text = "Set the target FPS (30, 60, 120, 144 or 240)."

func _button_prompts_tooltip():
    tooltip.text = "Change what button prompts you see in-game."