extends TextureRect

func _input(event):
    if event is InputEventScreenTouch and event.pressed and get_rect().has_point(event.position):
        get_tree().change_scene_to_file("res://Scenes/system_information.tscn")
