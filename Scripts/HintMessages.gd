extends Area2D

const GRAPHICS_PATH = "res://Graphics/Info Signs/"

func get_button_image(type: String) -> String:
    match ControllerHandling.get_real_joy_name():
        "PS4 Controller", "PS5 Controller":
            return get_image_path(type, "ps")
        "Nintendo Switch Pro Controller":
            return get_image_path(type, "nswitch")
        "":
            if DisplayServer.is_touchscreen_available():
                return get_image_path(type, "xbox")
            else:
                return get_image_path(type, "kbd")
        _:
            return get_image_path(type, "xbox")

func get_image_path(type: String, controller: String) -> String:
    return "[img=48x48]" + GRAPHICS_PATH + controller + "-" + type.to_lower() + ".png[/img]"

func display_label(body, message: String):
    if body.is_in_group("Player"):
        var hint_message = get_node("/root/Test Level/HeadsUpDisplay/HintMessage")
        hint_message.set_label_text(message)

func _hint_1(body):
    var sonic: AnimatedSprite2D = get_node("/root/Test Level/SonicPlayer/Sonic/SonicSprite")
    var direction = "Left" if sonic.flip_h else "Right"
    var opp_direction = "Right" if sonic.flip_h else "Left"
    display_label(body, "Press %s to make Sonic run.\nPress %s while running to come to a stop faster." % [get_button_image(direction), get_button_image(opp_direction)])

func _hint_2(body):
    display_label(body, "Press %s to make Sonic jump.\nJumping while running up a slope will send him higher." % get_button_image("Jump"))

func _hint_3(body):
    var both_directions = get_button_image("Left") + " or " + get_button_image("Right")
    display_label(body, "Green walls can be wall jumped off of.\nHold %s against the wall to stick to it,\nand press %s to Wall Jump." % [both_directions, get_button_image("Jump")])

func _hint_4(body):
    var sonic: AnimatedSprite2D = get_node("/root/Test Level/SonicPlayer/Sonic/SonicSprite")
    var direction = "Right" if sonic.flip_h else "Left"
    display_label(body, "Press %s to perform Quick Spin.\nPress  %s + %s to perform Quick Spin Reversal." % [get_button_image("Spin"), get_button_image(direction), get_button_image("Spin")])

func _hint_5(body):
    display_label(body, "In the air, press %s + %s to perform Quick Spin Down." % [get_button_image("Down"), get_button_image("Spin")])

func _hint_6(body):
    var sonic: AnimatedSprite2D = get_node("/root/Test Level/SonicPlayer/Sonic/SonicSprite")
    var direction = "Left" if sonic.flip_h else "Right"
    var opp_direction = "Right" if sonic.flip_h else "Left"
    display_label(body, "In the air, press %s + %s to perform Quick Spin Comet,\n or press %s + %s to perform Quick Spin Comet Reversal." % [get_button_image("Down" + direction), get_button_image("Spin"), get_button_image("Down" + opp_direction), get_button_image("Spin")])

func _hint_7(body):
    display_label(body, "Keep running fast to build up the Velocity Gauge.\nAt max Velocity, Sonic will enter Velocity State.")

func _hint_8(body):
    display_label(body, "When in Velocity State, your speed is uncapped.\nEnter Velocity State and jump up this slope to reach the goal!")
