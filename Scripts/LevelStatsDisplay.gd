extends Control

@onready var level_name = LevelStats.level_name
@onready var level_time = LevelStats.level_time

func _ready():
    $VictoryMusic.play()
    $Level.text = level_name
    $VBoxContainer/Time.text = "You took %s minute(s) and %s second(s)." % [int(level_time / 60.0), level_time % 60]

func _process(_delta):
    if Input.is_action_just_pressed("Jump"):
        get_tree().change_scene_to_file("res://title-screen.tscn")
    elif Input.is_action_just_pressed("Spin"):
        get_tree().change_scene_to_file("res://test-level.tscn")
