extends Label

var timer = 0
var level_time: int
var level_time_enabled: bool = true

func _ready():
    level_time = 0
    LevelStats.stop_timer.connect(_on_stop_timer)

func _process(delta):
    if not level_time_enabled:
        return
    timer += delta
    if timer >= 1.0:
        level_time += 1
        timer = 0
    text = format_time(level_time)
    LevelStats.level_time = level_time

func _on_stop_timer():
    level_time_enabled = false

func format_time(time: int) -> String:
    var minutes: int = int(time / 60.0)
    var seconds: int = time % 60
    return "%02d:%02d" % [minutes, seconds]
