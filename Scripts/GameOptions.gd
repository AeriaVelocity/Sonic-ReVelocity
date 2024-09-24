extends Node

@onready var config = ConfigFile.new()

var full_screen: bool
var camera_smoothing: bool
var camera_smoothing_amount: int
var fps_cap: int
var button_prompts: int

func _ready():
    config.load("user://game-config.cfg")
    read_config()
    set_config()

func read_config():
    full_screen = config.get_value("settings", "full_screen", true)
    camera_smoothing = config.get_value("settings", "camera_smoothing", true)
    camera_smoothing_amount = config.get_value("settings", "camera_smoothing_amount", 18)
    fps_cap = config.get_value("settings", "fps_cap", 60)
    button_prompts = config.get_value("settings", "button_prompts", 0)

func set_config():
    config.set_value("settings", "full_screen", full_screen)
    config.set_value("settings", "camera_smoothing", camera_smoothing)
    config.set_value("settings", "camera_smoothing_amount", camera_smoothing_amount)
    config.set_value("settings", "fps_cap", fps_cap)
    config.set_value("settings", "button_prompts", button_prompts)
    read_config()
    apply_config()

func apply_config():
    # Full screen
    DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN if full_screen else DisplayServer.WINDOW_MODE_WINDOWED)

    # FPS cap
    match fps_cap:
        0:
            Engine.max_fps = 30
        1:
            Engine.max_fps = 60
        2:
            Engine.max_fps = 120
        _:
            Engine.max_fps = 0

    # Camera smoothing and button prompts will be handled elsewhere, using this
    # script's variables
