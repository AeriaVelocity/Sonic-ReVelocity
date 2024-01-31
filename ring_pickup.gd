extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Player")
	$RingSprite.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		var ring_sound = $RingSound
		ring_sound.play()
		hide()
		await(ring_sound.finished)
		queue_free()
