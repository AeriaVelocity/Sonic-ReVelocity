extends Control

var selected_option_index: int

var highlight: Sprite2D
var highlight_anim: AnimationPlayer
var menu_options: VBoxContainer
var tooltip: Label
var alert_message: Control

@onready var music: AudioStreamPlayer = get_node("/root/GlobalAudio/GlobalMusic")
@onready var PopupType = preload("res://Scripts/Popup.gd").PopupType

func _ready():
    highlight = $Highlight
    highlight.global_position.x = -30
    highlight_anim = $Highlight/AnimationPlayer
    menu_options = $MenuOptions
    tooltip = $Tooltip

    var menu_music: AudioStreamMP3 = load("res://Music/menu.mp3")
    music.stream = menu_music
    music.play()

    selected_option_index = 0
    update_highlight_position()

    var controller_count = Input.get_connected_joypads().size()
    var invalid_controllers = []
    for i in controller_count:
        var current_controller = Input.get_joy_name(i)
        if !Input.is_joy_known(i) and not invalid_controllers.has(current_controller):
            invalid_controllers.append(current_controller)

    if invalid_controllers.size() > 0:
        show_invalid_controller_message(invalid_controllers)

func update_highlight_position():
    highlight_anim.stop()
    highlight_anim.play("infromleft")
    var selected_option = menu_options.get_child(selected_option_index)
    highlight.global_position.y = selected_option.global_position.y

    for i in range(menu_options.get_child_count()):
        var option = menu_options.get_child(i)
        if i == selected_option_index:
            option.modulate = Color(0, 0, 0)
        else:
            option.modulate = Color(1, 1, 1)

func handle_input():
    if alert_message and alert_message.visible:
        return
    var sysinfo_prereq = Input.is_action_pressed("SysinfoPrereq1") and Input.is_action_pressed("SysinfoPrereq1")
    if Input.is_action_just_pressed("MenuUp"):
        selected_option_index = (selected_option_index - 1 + menu_options.get_child_count()) % menu_options.get_child_count()
        $MoveSound.play()
        update_highlight_position()
    elif Input.is_action_just_pressed("MenuDown"):
        selected_option_index = (selected_option_index + 1) % menu_options.get_child_count()
        $MoveSound.play()
        update_highlight_position()
    elif Input.is_action_just_pressed("Jump"):
        if GameOptions.reverse_a_b:
            show_back_to_intro_message()
        else:
            $SelectSound.play()
            activate_selected_option()
    elif Input.is_action_just_pressed("Spin"):
        if GameOptions.reverse_a_b:
            $SelectSound.play()
            activate_selected_option()
        else:
            show_back_to_intro_message()
    elif sysinfo_prereq and Input.is_action_just_pressed("Sysinfo"):
        get_tree().change_scene_to_file("res://Scenes/system_information.tscn")

func handle_tooltip():
    if selected_option_index == 0:
        tooltip.text = "Jump right into Sonic Re;Velocity and play the test level."
    elif selected_option_index == 1:
        tooltip.text = "Configure options and settings, including controller bindings."
    elif selected_option_index == 2:
        tooltip.text = "Quit Sonic Re;Velocity and return to %s." % OS.get_name().capitalize()
    else:
        tooltip.text = ""

func activate_selected_option():
    match selected_option_index:
        0:
            LevelStats.rings = 0
            music.stop()
            get_tree().change_scene_to_file("res://Scenes/test-level.tscn")
        1:
            get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")
        2:
            show_exit_message()

func funny_quit_message():
    var messages: Array = [
        "Where are you going? Come back!",
        "Are you sure you want to quit this great game?",
        PromptHelpers.format_string_tags("For speed and style, press {Spin}.\nFor work and worry, press {Jump}."),
        "Come oooon just play the game. We promise it's fun.",
        PromptHelpers.format_string_tags("Press {Jump} to let Dr. Eggman directly into your house."),
        "I bet you didn't get the X Rank, and now you're salty.",
        "Are you going back to Green Hill Zone Simulator?\nIs this really that bad?",
        "You're trying to say Sonic Superstars is better than this, huh?",
        "I've run out of ways to passively make fun of you. Help.",
        "I wonder if you found that 'hidden menu' yet.",
        "There's something awaiting you in the Test Level...\nIf you're skilled enough to get there, that is.",
        "So, you ever heard of DOOM? Yeah? Me too. I like that game. :)",
        "Okay, sure, there's not much content just yet, but don't leave so soon!",
        "Remember SAGE 2024? Yeah, that was nice.\nI really didn't expect everyone to like this game so much.",
        PromptHelpers.format_string_tags("Press {Up} {Up} {Down} {Down} {Left} {Right} {Left} {Right} {B} {A} to do nothing of importance.")
    ]
    return messages[randi_range(0, messages.size() - 1)]

func show_exit_message():
    alert_message = load("res://Scenes/popup.tscn").instantiate()
    alert_message.set_title_text("Exit Sonic Re;Velocity?")
    alert_message.set_message_text(funny_quit_message())
    alert_message.set_popup_type(PopupType.OkCancel)
    alert_message.set_ok_label("Exit Game")
    alert_message.connect("ok_pressed", func(): get_tree().quit())
    alert_message.connect("cancel_pressed", func(): alert_message.close_popup())
    add_child(alert_message)

func show_back_to_intro_message():
    alert_message = load("res://Scenes/popup.tscn").instantiate()
    alert_message.set_title_text("Back to intro?")
    alert_message.set_message_text("You are about to return to the intro video.\nTo quit Sonic Re;Velocity, use the [b]Exit[/b] option.")
    alert_message.set_popup_type(PopupType.OkCancel)
    alert_message.set_ok_label("Confirm")
    alert_message.set_cancel_label("Back to Menu")
    alert_message.connect("ok_pressed", back_to_intro)
    alert_message.connect("cancel_pressed", func(): alert_message.close_popup())
    add_child(alert_message)

func show_invalid_controller_message(controllers: Array):
    alert_message = load("res://Scenes/popup.tscn").instantiate()
    alert_message.set_title_text("Unknown Device Connected")
    if controllers.size() > 1:
        alert_message.set_message_text("""One or more invalid input devices (%s) have been detected.
These devices may cause invalid or erratic inputs to be registered.
Please disconnect these devices to ensure optimal play.
""" % ", ".join(controllers))
    else:
        alert_message.set_message_text("""An invalid input device (%s) has been detected.
This device may cause invalid or erratic inputs to be registered.
Please disconnect this device to ensure optimal play.
""" % ", ".join(controllers))
    alert_message.set_popup_type(PopupType.Ok)
    alert_message.set_ok_label("Close")
    alert_message.connect("ok_pressed", func(): alert_message.close_popup())
    add_child(alert_message)

func back_to_intro():
    music.stop()
    get_tree().change_scene_to_file("res://Scenes/intro.tscn")

func _process(_delta):
    handle_input()
    handle_tooltip()
