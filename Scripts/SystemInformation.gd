extends Control

@onready var sysinfo_label = $MarginContainer/VBoxContainer/SysInfo
var sysinfo_text: String

func handle_exit():
    if Input.is_action_just_pressed("Jump"):
        if ControllerHandling.get_real_joy_name() == "Nintendo Switch Pro Controller":
            get_tree().change_scene_to_file("res://Scenes/main-menu.tscn")
    elif Input.is_action_just_pressed("Spin"):
        get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func get_inputs() -> Dictionary:
    var inputs: Dictionary = {}
    var action_count = InputMap.get_actions()
    for i in action_count:
        var action = InputMap.action_get_events(i)
        if i.begins_with("ui_") or action.size() <= 0:
            continue
        inputs[i] = str(action)
    return inputs

func format_memory(mem: int) -> String:
    var megabytes = mem / 1024.0 / 1024.0
    return "%d MB" % megabytes

func update_info():
    var os_name: String = OS.get_distribution_name() + " " + OS.get_version()
    var engine_ver: String = Engine.get_version_info().string
    var memory: String = format_memory(OS.get_memory_info().free)
    var total_memory: String = format_memory(OS.get_memory_info().available)
    var is_touchscreen: String = "Yes" if DisplayServer.is_touchscreen_available() else "No"
    var inputs: Dictionary = get_inputs()
    var controller_count = Input.get_connected_joypads().size()
    var controller_names = []
    for i in controller_count:
        var to_append = Input.get_joy_name(i) + " (GUID " + Input.get_joy_guid(i) + ")"
        if !Input.is_joy_known(i):
            to_append = to_append + " (This device is not a valid controller.)"
        controller_names.append(to_append)

    sysinfo_text = """=== Sonic Re;Velocity System Information ===

== To Non-Developers ==
This system information is intended for developers of Sonic Re;Velocity. You aren't expected to understand this.
If you're not a developer, you probably got here by mistake.
If you ARE a developer, you still probably got here by mistake.
If you're an Easter egg hunter, congratulations! You win! You got the Hidden System Information Page Ending! I hope your friends find this concerning.
If you're a hacker looking for ways to rip the game apart, you won't find it here. (But maybe you can find it somewhere...)

== Basic information ==
Operating system: %s
Memory (RAM): %s/%s
Godot Engine version: %s
Touchscreen detected: %s

""" % [os_name, memory, total_memory, engine_ver, is_touchscreen]

    sysinfo_text += "== Controller information ==\n"
    sysinfo_text += "Connected controllers: \n"

    if controller_names.size() > 0:
        var index = 1
        for controller_name in controller_names:
            sysinfo_text += str(index) + ". " + controller_name + "\n"
            index += 1
    else:
        sysinfo_text += "- No \"real\" controllers detected. \"Real\" controllers are controllers recognised by Godot's `Input.is_joy_known()` function.\n"

    sysinfo_text += "Input mappings: \n"

    for input in inputs:
        sysinfo_text += "- " + input + ": " + inputs[input] + "\n"

    sysinfo_label.text = sysinfo_text

func _ready():
    update_info()

func _process(_delta):
    handle_exit()

func _on_copy_button_button_down():
    DisplayServer.clipboard_set(sysinfo_text)

func _on_update_button_button_down():
    update_info()

func _on_back_button_button_down():
    get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
