extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    var speed = get_node("/root/HudScripting").get_speed()
    value = speed
