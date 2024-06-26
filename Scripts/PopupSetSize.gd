extends ColorRect

func _ready():
    call_deferred("initialise")

func initialise():
    size = get_viewport_rect().size / 2
    position = get_viewport_rect().size / 4
    $MessageContainer.size.y = size.y - $TitleBar.size.y - $CloseButton.size.y
    $MessageContainer.position.y = $TitleBar.size.y
    pivot_offset = size / 2
    $AlertSound.play()
    $AnimationPlayer.play("show")

func _process(_delta):
    set_close_button_icon()

func set_close_button_icon():
    var button_prompt: CompressedTexture2D
    match ControllerHandling.get_real_joy_name():
        "XInput Gamepad", "Xbox One Controller", "Xbox 360 Controller":
            button_prompt = preload("res://Graphics/Info Signs/xbox-jump.png")
        "PS4 Controller", "PS5 Controller":
            button_prompt = preload("res://Graphics/Info Signs/ps-jump.png")
        "Nintendo Switch Pro Controller":
            button_prompt = preload("res://Graphics/Info Signs/nswitch-jump.png")
        "":
            button_prompt = preload("res://Graphics/Info Signs/kbd-jump.png")
        _:
            button_prompt = preload("res://Graphics/Info Signs/xbox-jump.png")

    $CloseButton.set_button_icon(button_prompt)

