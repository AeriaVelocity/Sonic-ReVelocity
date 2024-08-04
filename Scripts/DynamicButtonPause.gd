extends Node2D

func _process(_delta):
    var game_paused = get_tree().paused

    if game_paused:
        $Unused1.show()
        $JumpButton.hide()
    else:
        $Unused1.hide()
        $JumpButton.show()
