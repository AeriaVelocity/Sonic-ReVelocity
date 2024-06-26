extends Label

func _process(_delta):
    var speed = get_node("/root/HudScripting").get_speed()
    set_text("Speed: %d m/s" % int(speed))
