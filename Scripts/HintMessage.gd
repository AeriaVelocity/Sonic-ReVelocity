extends RichTextLabel

func set_label_text(message: String):
    if $HintAnim.is_playing():
        $HintAnim.stop()
    $HintSound.play()
    text = "[center]" + message + "[/center]"
    $HintAnim.play("fadeout")
