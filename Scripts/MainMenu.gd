extends Control

var selected_option_index: int

var highlight: Sprite2D
var highlight_anim: AnimationPlayer
var menu_options: VBoxContainer
var tooltip: Label
var exit_message: Control

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
    if exit_message and exit_message.visible:
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
        if GameOptions.button_prompts == GameOptions.Buttons.Switch:
            music.stop()
            get_tree().change_scene_to_file("res://Scenes/intro.tscn")
        else:
            $SelectSound.play()
            activate_selected_option()
    elif Input.is_action_just_pressed("Spin"):
        if GameOptions.button_prompts == GameOptions.Buttons.Switch:
            $SelectSound.play()
            activate_selected_option()
        else:
            music.stop()
            get_tree().change_scene_to_file("res://Scenes/intro.tscn")
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

func show_exit_message():
    exit_message = load("res://Scenes/popup.tscn").instantiate()
    exit_message.set_title_text("Exit Sonic Re;Velocity?")
    exit_message.set_message_text("Are you sure you want to quit?")
    exit_message.set_popup_type(PopupType.ExitGame)
    exit_message.connect("ok_pressed", func(): get_tree().quit())
    exit_message.connect("cancel_pressed", func(): exit_message.close_popup())
    add_child(exit_message)

func _process(_delta):
    handle_input()
    handle_tooltip()
