extends RichTextLabel

const GRAPHICS_PATH = "res://Graphics/Info Signs/"

var original_text: String

func up_button() -> String:
    match ControllerHandling.get_real_joy_name():
        "PS4 Controller", "PS5 Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "ps-up.png[/img]"
        "Nintendo Switch Pro Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "nswitch-up.png[/img]"
        "":
            if DisplayServer.is_touchscreen_available():
                return "[img=64x64]" + GRAPHICS_PATH + "xbox-up.png[/img]"
            else:
                return "[img=64x64]" + GRAPHICS_PATH + "kbd-up.png[/img]"
        _:
            return "[img=64x64]" + GRAPHICS_PATH + "xbox-up.png[/img]"

func down_button() -> String:
    match ControllerHandling.get_real_joy_name():
        "PS4 Controller", "PS5 Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "ps-down.png[/img]"
        "Nintendo Switch Pro Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "nswitch-down.png[/img]"
        "":
            if DisplayServer.is_touchscreen_available():
                return "[img=64x64]" + GRAPHICS_PATH + "xbox-down.png[/img]"
            else:
                return "[img=64x64]" + GRAPHICS_PATH + "kbd-down.png[/img]"
        _:
            return "[img=64x64]" + GRAPHICS_PATH + "xbox-down.png[/img]"

func jump_button() -> String:
    match ControllerHandling.get_real_joy_name():
        "PS4 Controller", "PS5 Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "ps-jump.png[/img]"
        "Nintendo Switch Pro Controller":
            # Because Nintendo controllers have A and B flipped compared to Xbox
            return "[img=64x64]" + GRAPHICS_PATH + "nswitch-spin.png[/img]"
        "":
            if DisplayServer.is_touchscreen_available():
                return "[img=64x64]" + GRAPHICS_PATH + "xbox-jump.png[/img]"
            else:
                return "[img=64x64]" + GRAPHICS_PATH + "kbd-jump.png[/img]"
        _:
            return "[img=64x64]" + GRAPHICS_PATH + "xbox-jump.png[/img]"

func spin_button() -> String:
    match ControllerHandling.get_real_joy_name():
        "PS4 Controller", "PS5 Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "ps-spin.png[/img]"
        "Nintendo Switch Pro Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "nswitch-jump.png[/img]"
        "":
            if DisplayServer.is_touchscreen_available():
                return "[img=64x64]" + GRAPHICS_PATH + "xbox-spin.png[/img]"
            else:
                return "[img=64x64]" + GRAPHICS_PATH + "kbd-spin.png[/img]"
        _:
            return "[img=64x64]" + GRAPHICS_PATH + "xbox-spin.png[/img]"

func special1_button() -> String:
    match ControllerHandling.get_real_joy_name():
        "PS4 Controller", "PS5 Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "ps-unused1.png[/img]"
        "Nintendo Switch Pro Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "nswitch-unused1.png[/img]"
        "":
            if DisplayServer.is_touchscreen_available():
                return "[img=64x64]" + GRAPHICS_PATH + "xbox-unused1.png[/img]"
            else:
                return "[img=64x64]" + GRAPHICS_PATH + "kbd-unused1.png[/img]"
        _:
            return "[img=64x64]" + GRAPHICS_PATH + "xbox-unused1.png[/img]"

func special2_button() -> String:
    match ControllerHandling.get_real_joy_name():
        "PS4 Controller", "PS5 Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "ps-unused2.png[/img]"
        "Nintendo Switch Pro Controller":
            return "[img=64x64]" + GRAPHICS_PATH + "nswitch-unused2.png[/img]"
        "":
            if DisplayServer.is_touchscreen_available():
                return "[img=64x64]" + GRAPHICS_PATH + "xbox-unused2.png[/img]"
            else:
                return "[img=64x64]" + GRAPHICS_PATH + "kbd-unused2.png[/img]"
        _:
            return "[img=64x64]" + GRAPHICS_PATH + "xbox-unused2.png[/img]"

func _ready():
    original_text = text

func _process(_delta):
    set_text(original_text.format({"Up": up_button(), "Down": down_button(), "Jump": jump_button(), "Spin": spin_button(), "Special1": special1_button(), "Special2": special2_button()}))
