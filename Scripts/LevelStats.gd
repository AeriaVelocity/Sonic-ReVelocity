extends Node

var level_name := "Unnamed"
var level_time := 0.0
var rings := 0

signal collect_ring
signal stop_timer

func _ready():
    collect_ring.connect(_on_collect_ring)

func _on_collect_ring():
    rings += 1

func format_time(time: float) -> String:
    var minutes: float = time / 60.0
    var seconds: float = int(time) % 60
    var milliseconds: float = int(time * 1000) % 1000
    return "%02d:%02d.%03d" % [int(minutes), int(seconds), int(milliseconds)]