extends Control

@onready var level_name = LevelStats.level_name
@onready var level_time = LevelStats.level_time

func _ready():
    $VictoryMusic.play()
    $Level.text = level_name
    $VBoxContainer/Time.text = "Time: %s" % format_time(level_time)
    $VBoxContainer/Rings.text = "Rings: %s" % LevelStats.rings

func format_time(time: int) -> String:
    var minutes: int = int(time / 60.0)
    var seconds: int = time % 60
    return "%02d:%02d" % [minutes, seconds]

func _process(_delta):
    if Input.is_action_just_pressed("Jump"):
        get_tree().change_scene_to_file("res://title-screen.tscn")
    elif Input.is_action_just_pressed("Spin"):
        get_tree().change_scene_to_file("res://test-level.tscn")
