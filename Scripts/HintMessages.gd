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
    return "[img=42x42]" + GRAPHICS_PATH + controller + "-" + type.to_lower() + ".png[/img]"

func display_label(body, message: String):
    if body.is_in_group("Player"):
        var hint_message = get_node("/root/Test Level/HeadsUpDisplay/HintMessage")
        hint_message.set_label_text(message)

func _hint_1(body):
    var sonic: AnimatedSprite2D = get_node("/root/Test Level/SonicPlayer/Sonic/SonicSprite")
    var direction = "Left" if sonic.flip_h else "Right"
    display_label(body, "Press %s to make Sonic run.\nSonic's current speed can be seen in the blue Speed Gauge,\ndisplayed in f/s (fasts per speed)." % [get_button_image(direction)])

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
    display_label(body, "Keep running fast to build up the purple Velocity Gauge.\nAt max Velocity, Sonic will enter Velocity State.\nUse Quick Spin (%s) to increase your speed." % get_button_image("Spin"))

func _hint_8(body):
    display_label(body, "When in Velocity State, Sonic will gain speed much faster.\nEnter Velocity State and jump up the slope at the end to reach the goal!")

func _hint_9(body):
    var random_messages = [
        "How did you even get up here?",
        "There is no hint! Message intentionally left blank.",
        "Wait, you actually made it here? I didn't plan an Easter egg for this...",
        "Wow, good job! If you missed, you would have fallen down to the actual level.",
        "Can you believe this game shares its codebase with a silly joke game I threw together? The intro video from Green Hill Zone Simulator is still in Sonic Re;Velocity's codebase right now.",
        "I hope you don't accidentally press %s and Quick Spin off this platform.\nIf you did, you wouldn't get to sit here and read these messages!" % get_button_image("Spin"),
        "So, how are you enjoying the game so far? Good? Well, I'm glad you're probably having fun.",
        "Yeah, this is the only level in this demo. Sorry. :D",
        "I wonder if I should keep working on this game after SAGE...",
        "So, played any good games today? Ones from SAGE, maybe?\nNot including this one, obviously.",
        "I've been thinking about remaking Sonic and the Black Knight.\nKinda like Project Reignited, but Black Knight instead of Secret Rings.\nI dunno, what do you think?",
        "You know, you're probably gonna get a D Rank for taking so long reading these stupid messages.",
        "It's called Sonic [b]Re;[/b]Velocity because there's already a Sonic Velocity.",
        "The [i]Re[/i] in Sonic Re;Velocity stands for Renewed.\nSo if you want, you can call it Sonic Renewed Velocity.",
    ]
    if ControllerHandling.get_real_joy_name() == "" and !DisplayServer.is_touchscreen_available():
        random_messages.append(
            "You can access a secret System Information page on the title screen!\nPress and hold the left and right mouse buttons and press V to access it."
        )
    elif ControllerHandling.get_real_joy_name() != "":
        random_messages.append(
            "You can access a secret System Information page on the title screen!\nPress and hold the left and right triggers and press %s to access it."
            % get_button_image("Unused2")
        )
    display_label(body, random_messages[randi_range(0, random_messages.size() - 1)])
