extends Area2D

const GRAPHICS_PATH = "res://Graphics/Info Signs/"

func get_button_image(type: String) -> String:
    if GameOptions.button_prompts == 0: # Automatic
        match Input.get_joy_name(0):
            "PS4 Controller", "PS5 Controller":
                return get_image_path(type, "ps")
            "Nintendo Switch Pro Controller":
                return get_image_path(type, "nswitch")
            "XInput Gamepad", "Xbox 360 Controller", "Xbox One Controller", "Xbox Series Controller":
                return get_image_path(type, "xbox")
            "":
                if DisplayServer.is_touchscreen_available():
                    return get_image_path(type, "xbox")
                else:
                    return get_image_path(type, "kbd")
            _:
                return get_image_path(type, "generic")
    else:
        match GameOptions.button_prompts:
            1: # Xbox
                return get_image_path(type, "xbox")
            2: # PlayStation
                return get_image_path(type, "ps")
            3: # Switch Pro
                return get_image_path(type, "nswitch")
            5: # Keyboard
                return get_image_path(type, "kbd")
            _: # Positional (4), or fallback
                return get_image_path(type, "generic")

func get_image_path(type: String, controller: String) -> String:
    return "[img=64x64]" + GRAPHICS_PATH + controller + "-" + type.to_lower() + ".png[/img]"

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
    if Input.get_joy_name(0) == "" and !DisplayServer.is_touchscreen_available():
        random_messages.append(
            "You can access a secret System Information page on the title screen!\nPress and hold the left and right mouse buttons and press %s to access it."
            % get_button_image("Unused2")
        )
    elif Input.get_joy_name(0) != "":
        random_messages.append(
            "You can access a secret System Information page on the title screen!\nPress and hold the left and right triggers and press %s to access it."
            % get_button_image("Unused2")
        )
    elif DisplayServer.is_touchscreen_available():
        random_messages.append(
            "You can access a secret System Information page on the title screen!\nTouch the Sonic Re;Velocity logo at the top right of the screen to access it."
        )
    display_label(body, random_messages[randi_range(0, random_messages.size() - 1)])

func _hint_10(body):
    var random_messages = [
        "How did you even get DOWN here?!",
        "Well, congratulations! You missed the death plane and now you're stuck down here.",
        "Oh, dear, you're going to have to restart the level now.",
        "Well done! You found the Ultimate Easter Egg: Nothing. Enjoy your stay.",
        "I don't think you're even Sonic. Sonic would never do this.",
        "If you jump off either edge of this platform, you're going to be falling in the infinite void.",
        "No Way? No Way! No Way? No Way! No Way? No Way! No Way? No Way!",
        "No, you can't do it that way! Use all the other ways to finish the level!",
        "I bet this isn't even the first SAGE game you've gotten stuck at.",
        "Hey, if this was Green Hill Zone Simulator, I'd have shown you a BSOD.",
        "Fun is ∞ with AeriaVelocity. - Aeria",
        "No, this isn't how you're supposed to play the game.",
        "Frick, I ran out of ways to passively ridicule you.\nYou'll just have to insult yourself."
    ]
    display_label(body, random_messages[randi_range(0, random_messages.size() - 1)])
