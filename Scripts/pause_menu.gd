extends Control

func _input(event):
    if event.is_action_pressed("Start"):
        if not visible:
            pause_game()
        else:
            unpause_game()

    if visible:
        if event.is_action_pressed("Spin") && not GameOptions.reverse_a_b:
            return_to_main_menu()
        if event.is_action_pressed("Jump") && GameOptions.reverse_a_b:
            return_to_main_menu()
        if event.is_action_pressed("Unused1"):
            restart_level()

func pause_game():
    $Open.play()
    show()
    get_tree().paused = true

func unpause_game():
    $Close.play()
    hide()
    get_tree().paused = false

func return_to_main_menu():
    hide()
    get_tree().paused = false
    get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func restart_level():
    get_tree().paused = false
    LevelStats.rings = 0
    get_tree().reload_current_scene()
