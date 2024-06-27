extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
    add_to_group("Player")
    $RingSprite.play("default")

func _on_body_entered(body):
    if body.is_in_group("Player"):
        var ring_sound = $RingSound
        ring_sound.play()
        LevelStats.collect_ring.emit()
        hide()
        await(ring_sound.finished)
        queue_free()
