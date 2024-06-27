extends ProgressBar

var velocity_gauge = VelocitySystem.velocity_gauge
const velocity_gauge_max: int = 1000

var global_delta: float

func _ready():
    velocity_gauge = 0
    VelocitySystem.connect("increment_velocity_gauge", increment)

var flash_counter: float
var reset_counter: float
var do_flash: bool = false

func _process(delta):
    if velocity_gauge >= 1 and reset_counter <= 0:
        velocity_gauge -= 7
    value = velocity_gauge

    flash_counter += delta

    if reset_counter > 0:
        reset_counter -= delta

    if velocity_gauge >= velocity_gauge_max - 5:
        if flash_counter > 0.1:
            do_flash = not do_flash
            flash_counter = 0.0
        VelocitySystem.velocity_state = true
    else:
        VelocitySystem.velocity_state = false

    if do_flash and velocity_gauge >= velocity_gauge_max - 5:
        self_modulate = Color.SKY_BLUE
    else:
        self_modulate = Color.WHITE

    global_delta = delta

func increment(amount: int):
    if velocity_gauge < velocity_gauge_max:
        velocity_gauge += amount
    reset_counter = amount * global_delta
