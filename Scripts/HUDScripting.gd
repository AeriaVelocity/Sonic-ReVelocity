extends Node

var speed: float

func _ready():
	pass # Replace with function body.
	
func update_speed(velocity: Vector2):
	speed = sqrt(velocity.x ** 2 + velocity.y ** 2)

func get_speed() -> float:
	return speed
