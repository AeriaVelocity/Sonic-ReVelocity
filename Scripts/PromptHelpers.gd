extends Node

const GRAPHICS_PATH = "res://Graphics/Info Signs/"

func get_controller_specific_prompt(button: String) -> String:
    if GameOptions.button_prompts == GameOptions.Buttons.Automatic:
        match Input.get_joy_name(0):
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
    else:
        match GameOptions.button_prompts:
            1: # Xbox
                return "[img=64x64]" + GRAPHICS_PATH + "xbox-" + button + ".png[/img]"
            2: # PlayStation
                return "[img=64x64]" + GRAPHICS_PATH + "ps-" + button + ".png[/img]"
            3: # Switch Pro
                return "[img=64x64]" + GRAPHICS_PATH + "nswitch-" + button + ".png[/img]"
            5: # Keyboard
                return "[img=64x64]" + GRAPHICS_PATH + "kbd-" + button + ".png[/img]"
            _: # Positional (4), or fallback
                return "[img=64x64]" + GRAPHICS_PATH + "generic-" + button + ".png[/img]"

func up_button() -> String:
    return get_controller_specific_prompt("up")

func down_button() -> String:
    return get_controller_specific_prompt("down")

func left_button() -> String:
    return get_controller_specific_prompt("left")

func right_button() -> String:
    return get_controller_specific_prompt("right")

func jump_button() -> String:
    if GameOptions.button_prompts == GameOptions.Buttons.Switch:
        return get_controller_specific_prompt("spin")
    else:
        return get_controller_specific_prompt("jump")

func spin_button() -> String:
    if GameOptions.button_prompts == GameOptions.Buttons.Switch:
        return get_controller_specific_prompt("jump")
    else:
        return get_controller_specific_prompt("spin")

func special1_button() -> String:
    return get_controller_specific_prompt("unused1")

func special2_button() -> String:
    return get_controller_specific_prompt("unused2")

func format_string_tags(text: String) -> String:
    var formatted_text = text.format(
        {
            "Up": up_button(),
            "Down": down_button(),
            "Left": left_button(),
            "Right": right_button(),
            "Jump": jump_button(),
            "Spin": spin_button(),
            "Special1": special1_button(),
            "Special2": special2_button(),
            "A": jump_button(),
            "B": spin_button(),
            "X": special1_button(),
            "Y": special2_button()
        }
    )
    return formatted_text
