extends Control

var selected_option_index: int

var highlight: Sprite2D
var highlight_anim: AnimationPlayer
var menu_options: VBoxContainer
var tooltip: Label
var unimplemented_popup: Control

func _ready():
    highlight = $Highlight
    highlight.global_position.x = -30
    highlight_anim = $Highlight/AnimationPlayer
    menu_options = $MenuOptions
    tooltip = $Tooltip

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
    if unimplemented_popup and unimplemented_popup.visible:
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
        if Input.get_joy_name(0) == "Nintendo Switch Pro Controller":
            get_tree().change_scene_to_file("res://intro.tscn")
        else:
            $SelectSound.play()
            activate_selected_option()
    elif Input.is_action_just_pressed("Spin"):
        if Input.get_joy_name(0) == "Nintendo Switch Pro Controller":
            $SelectSound.play()
            activate_selected_option()
        else:
            get_tree().change_scene_to_file("res://intro.tscn")
    elif sysinfo_prereq and Input.is_action_just_pressed("Sysinfo"):
        get_tree().change_scene_to_file("res://system_information.tscn")

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
            get_tree().change_scene_to_file("res://test-level.tscn")
        1:
            unimplemented_popup = preload("res://popup.tscn").instantiate()
            add_child(unimplemented_popup)
            unimplemented_popup.title_text = "Unimplemented"
            unimplemented_popup.message_text = "The options menu is not yet implemented.\nPlease check back in a future update."
        2:
            get_tree().quit()

func _process(_delta):
    handle_input()
    handle_tooltip()
