extends Node

var speed: float

func _ready():
    pass # Replace with function body.

func update_speed(velocity: Vector2):
    speed = abs(velocity.x)

func get_speed() -> float:
    return speed
