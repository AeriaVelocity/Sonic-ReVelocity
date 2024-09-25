extends Control

@onready var level_name = LevelStats.level_name
@onready var level_time = LevelStats.level_time

func _ready():
    $VictoryMusic.play()
    $AnimationPlayer.play("show")
    $Panel/Level.text = level_name
    $Panel/VBoxContainer/Time.text = "Time: %s" % LevelStats.format_time(level_time)
    $Panel/VBoxContainer/Rings.text = "Rings: %s" % LevelStats.rings
    $Panel/Rank.text = determine_rank()[0]
    $Panel/Rank.modulate = determine_rank()[1]

func determine_rank() -> Array:
    # Ideally this wouldn't be hardcoded, but there's only one level so I'll do that later :3
    if level_time < 13 and LevelStats.rings >= 90:
        return ["X", Color.DEEP_SKY_BLUE]
    elif level_time < 13:
        return ["S", Color.GOLD]
    elif level_time >= 13 and level_time < 15:
        return ["A", Color.DODGER_BLUE]
    elif level_time >= 15 and level_time < 20:
        return ["B", Color.ORANGE_RED]
    elif level_time >= 20 and level_time < 30:
        return ["C", Color.YELLOW]
    elif level_time >= 30:
        return ["D", Color.SLATE_GRAY]
    return ["How did you even", Color.GRAY]

func _process(_delta):
    if Input.is_action_just_pressed("Jump"):
        if GameOptions.button_prompts == GameOptions.Buttons.Switch:
            get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
        else:
            get_tree().change_scene_to_file("res://Scenes/thanks.tscn")
    elif Input.is_action_just_pressed("Spin"):
        if GameOptions.button_prompts == GameOptions.Buttons.Switch:
            get_tree().change_scene_to_file("res://Scenes/thanks.tscn")
        else:
            get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
    elif Input.is_action_just_pressed("Unused1"):
        LevelStats.rings = 0
        get_tree().change_scene_to_file("res://Scenes/test-level.tscn")
