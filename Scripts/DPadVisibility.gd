extends Sprite2D

func _ready():
	visible = DisplayServer.is_touchscreen_available()

func _process(_delta):
	visible = DisplayServer.is_touchscreen_available()