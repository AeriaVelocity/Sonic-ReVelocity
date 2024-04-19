extends "res://Scripts/ButtonPrompts.gd"

func _process(delta):
	var sonic: AnimatedSprite2D = get_node("/root/Test Level/SonicPlayer/Sonic/SonicSprite")
	flip_h = sonic.flip_h
	super._process(delta)
