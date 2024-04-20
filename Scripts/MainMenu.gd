extends Control

var selected_option_index: int

var highlight: Sprite2D
var highlight_anim: AnimationPlayer
var menu_options: VBoxContainer

func _ready():
	highlight = $Highlight
	highlight_anim = $Highlight/AnimationPlayer
	menu_options = $MenuOptions
	
	selected_option_index = 0

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
	if Input.is_action_just_pressed("ui_up"):
		selected_option_index = (selected_option_index - 1 + menu_options.get_child_count()) % menu_options.get_child_count()
		$MoveSound.play()
		update_highlight_position()
	elif Input.is_action_just_pressed("ui_down"):
		selected_option_index = (selected_option_index + 1) % menu_options.get_child_count()
		$MoveSound.play()
		update_highlight_position()
	elif Input.is_action_just_pressed("Jump"):
		$SelectSound.play()
		activate_selected_option()
	elif Input.is_action_just_pressed("Spin"):
		get_tree().change_scene_to_file("res://title-screen.tscn")
		
func activate_selected_option():
	match selected_option_index:
		0:
			get_tree().change_scene_to_file("res://test-level.tscn")
		1:
			get_tree().quit()

func _process(_delta):
	handle_input()
