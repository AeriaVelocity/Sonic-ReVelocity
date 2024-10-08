extends Node

enum Buttons {
    Automatic,
    Xbox,
    PlayStation,
    Switch,
    Positional,
    Keyboard
}

enum TouchControls {
    Never,
    TouchOnly,
    Always
}

@onready var config = ConfigFile.new()

var full_screen: bool
var camera_smoothing: bool
var camera_smoothing_amount: int
var velocity_trails: bool
var fps_cap: int
var button_prompts: int
var reverse_a_b: bool
var touch_controls: int

const CONFIG_FILE = "user://game-config.cfg"

func _ready():
    config.load(CONFIG_FILE)
    read_config()
    set_config()

func read_config():
    full_screen = config.get_value("settings", "full_screen", true)
    camera_smoothing = config.get_value("settings", "camera_smoothing", true)
    camera_smoothing_amount = config.get_value("settings", "camera_smoothing_amount", 18)
    velocity_trails = config.get_value("settings", "velocity_trails", true)
    fps_cap = config.get_value("settings", "fps_cap", 60)
    button_prompts = config.get_value("settings", "button_prompts", 0)
    reverse_a_b = config.get_value("settings", "reverse_a_b", false)
    touch_controls = config.get_value("settings", "touch_controls", 1)

func set_config():
    config.set_value("settings", "full_screen", full_screen)
    config.set_value("settings", "camera_smoothing", camera_smoothing)
    config.set_value("settings", "camera_smoothing_amount", camera_smoothing_amount)
    config.set_value("settings", "velocity_trails", velocity_trails)
    config.set_value("settings", "fps_cap", fps_cap)
    config.set_value("settings", "button_prompts", button_prompts)
    config.set_value("settings", "reverse_a_b", reverse_a_b)
    config.set_value("settings", "touch_controls", touch_controls)
    read_config()
    apply_config()
    config.save(CONFIG_FILE)

func apply_config():
    # Full screen
    DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN if full_screen else DisplayServer.WINDOW_MODE_WINDOWED)

    # FPS cap
    Engine.max_fps = fps_cap

    # Camera smoothing and button prompts will be handled elsewhere, using this
    # script's variables
