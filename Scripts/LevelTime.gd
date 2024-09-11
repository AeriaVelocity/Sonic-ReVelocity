extends Label

var timer = 0.0
var level_time = 0
var level_time_enabled: bool = true

func _ready():
    LevelStats.stop_timer.connect(_on_stop_timer)

func _process(delta):
    if not level_time_enabled:
        return
    timer += delta
    text = LevelStats.format_time(timer)
    LevelStats.level_time = timer

func _on_stop_timer():
    level_time_enabled = false

