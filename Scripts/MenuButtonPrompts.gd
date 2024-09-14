extends RichTextLabel

const GRAPHICS_PATH = "res://Graphics/Info Signs/"

var original_text: String

func get_controller_specific_prompt(button: String) -> String:
    match ControllerHandling.get_real_joy_name():
        "PS4 Controller", "PS5 Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "ps-" + button + ".png[/img]"
        "Nintendo Switch Pro Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "nswitch-" + button + ".png[/img]"
        "XInput Gamepad", "Xbox 360 Controller", "Xbox One Controller", "Xbox Series Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "xbox-" + button + ".png[/img]"
        "":
            if DisplayServer.is_touchscreen_available():
                return "[img=64x64]" + GRAPHICS_PATH + "xbox-" + button + ".png[/img]"
            else:
                return "[img=64x64]" + GRAPHICS_PATH + "kbd-" + button + ".png[/img]"
        _:
            return "[img=64x64]" + GRAPHICS_PATH + "generic-" + button + ".png[/img]"

func up_button() -> String:
    return get_controller_specific_prompt("up")

func down_button() -> String:
    return get_controller_specific_prompt("down")

func jump_button() -> String:
    return get_controller_specific_prompt("jump")

func spin_button() -> String:
    return get_controller_specific_prompt("spin")

func special1_button() -> String:
    return get_controller_specific_prompt("unused1")

func special2_button() -> String:
    return get_controller_specific_prompt("unused2")

func _ready():
    original_text = text

func _process(_delta):
    match ControllerHandling.get_real_joy_name():
        "Nintendo Switch Pro Controller":
            set_text(original_text.format({"Up": up_button(), "Down": down_button(), "Jump": spin_button(), "Spin": jump_button(), "Special1": special1_button(), "Special2": special2_button()}))
        _:
            set_text(original_text.format({"Up": up_button(), "Down": down_button(), "Jump": jump_button(), "Spin": spin_button(), "Special1": special1_button(), "Special2": special2_button()}))
