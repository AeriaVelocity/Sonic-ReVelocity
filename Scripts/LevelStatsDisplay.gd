extends Control

@onready var level_name = LevelStats.level_name
@onready var level_time = LevelStats.level_time

func _ready():
    $VictoryMusic.play()
    $AnimationPlayer.play("show")
    $Panel/Level.text = level_name
    $Panel/VBoxContainer/Time.text = "Time: %s" % format_time(level_time)
    $Panel/VBoxContainer/Rings.text = "Rings: %s" % LevelStats.rings
    $Panel/Rank.text = determine_rank()[0]
    $Panel/Rank.modulate = determine_rank()[1]

func format_time(time: int) -> String:
    var minutes: int = int(time / 60.0)
    var seconds: int = time % 60
    return "%02d:%02d" % [minutes, seconds]

func determine_rank() -> Array:
    if level_time < 20 and LevelStats.rings >= 80:
        return ["X", Color.DEEP_SKY_BLUE]
    elif level_time < 20:
        return ["S", Color.GOLD]
    elif level_time >= 20 and level_time < 30:
        return ["A", Color.DODGER_BLUE]
    elif level_time >= 30 and level_time < 45:
        return ["B", Color.ORANGE_RED]
    elif level_time >= 45 and level_time < 60:
        return ["C", Color.YELLOW]
    elif level_time >= 60:
        return ["D", Color.SLATE_GRAY]
    return ["How did you even", Color.GRAY]

func _process(_delta):
    if Input.is_action_just_pressed("Jump"):
        get_tree().change_scene_to_file("res://thanks.tscn")
    elif Input.is_action_just_pressed("Spin"):
        LevelStats.rings = 0
        get_tree().change_scene_to_file("res://test-level.tscn")
    elif Input.is_action_just_pressed("Unused1"):
        get_tree().change_scene_to_file("res://intro.tscn")
