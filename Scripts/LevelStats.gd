extends Node

var level_name := "Unnamed"
var level_time := 0
var rings := 0

signal collect_ring
signal stop_timer

func _ready():
    collect_ring.connect(_on_collect_ring)

func _on_collect_ring():
    rings += 1
