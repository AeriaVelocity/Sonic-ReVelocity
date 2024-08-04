extends Label

func _process(_delta):
    var speed = get_node("/root/HudScripting").get_speed()
    set_text("%.2f" % float(int(speed) / 100.0))
