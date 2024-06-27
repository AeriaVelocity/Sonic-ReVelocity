extends Node2D

var ring_touched = false

func _on_ring_touched(body):
    if body.is_in_group("Player") and not ring_touched:
        ring_touched = true
        $AnimatedSprite2D/AnimationPlayer.play("shrink_ring")
        $Get.play()
        LevelStats.level_name = get_tree().current_scene.name
        await($AnimatedSprite2D/AnimationPlayer.animation_finished)
        get_tree().change_scene_to_file("res://level_stats.tscn")
