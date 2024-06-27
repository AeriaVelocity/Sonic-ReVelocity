extends Label

var timer = 0
var level_time: int

func _ready():
    level_time = 0

func _process(delta):
    timer += delta
    if timer >= 1.0:
        level_time += 1
        timer = 0
    text = format_time(level_time)
    LevelStats.level_time = level_time

func format_time(time: int) -> String:
    var minutes: int = int(time / 60.0)
    var seconds: int = time % 60
    return "%02d:%02d" % [minutes, seconds]
