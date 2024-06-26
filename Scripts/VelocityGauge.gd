extends ProgressBar

var velocity_gauge = VelocitySystem.velocity_gauge
const velocity_gauge_max: int = 255

func _ready():
    velocity_gauge = 0
    VelocitySystem.connect("increment_velocity_gauge", increment)

var counter: float
var do_flash: bool = false

func _process(delta):
    if velocity_gauge >= 1:
        velocity_gauge -= 1
    value = velocity_gauge

    counter += delta

    if velocity_gauge >= velocity_gauge_max - 5:
        if counter > 0.1:
            do_flash = not do_flash
            counter = 0.0
        VelocitySystem.velocity_state = true
    else:
        VelocitySystem.velocity_state = false

    if do_flash and velocity_gauge >= velocity_gauge_max - 5:
        self_modulate = Color.SKY_BLUE
    else:
        self_modulate = Color.WHITE

func increment(amount: int):
    if velocity_gauge < velocity_gauge_max:
        velocity_gauge += amount
