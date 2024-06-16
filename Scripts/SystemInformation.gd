extends Control

@onready var sysinfo_label = $MarginContainer/VBoxContainer/SysInfo
var sysinfo_text: String

func handle_exit():
	if Input.is_action_just_pressed("Jump"):
		if ControllerHandling.get_real_joy_name() == "Nintendo Switch Pro Controller":
			get_tree().change_scene_to_file("res://main-menu.tscn")
	elif Input.is_action_just_pressed("Spin"):
		get_tree().change_scene_to_file("res://main_menu.tscn")

func update_info():
	var os_name: String = OS.get_distribution_name() + " " + OS.get_version()
	var is_touchscreen: bool = DisplayServer.is_touchscreen_available()
	var controller_count = Input.get_connected_joypads().size()
	var controller_names = []
	for i in controller_count:
		if !Input.is_joy_known(i):
			continue
		controller_names.append(Input.get_joy_name(i) + " (GUID " + Input.get_joy_guid(i) + ")")

	sysinfo_text = """=== Sonic Re;Velocity System Information ===

Operating system: %s
Touchscreen: %s
Connected controllers:
""" % [os_name, is_touchscreen]

	for controller_name in controller_names:
		sysinfo_text += "- " + controller_name + "\n"

	sysinfo_label.text = sysinfo_text

func _process(_delta):
	update_info()
	handle_exit()

func _on_copy_button_button_down():
	DisplayServer.clipboard_set(sysinfo_text)
