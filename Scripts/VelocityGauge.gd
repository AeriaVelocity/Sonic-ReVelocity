extends ProgressBar

var velocity_gauge = VelocitySystem.velocity_gauge
const velocity_gauge_max: int = 1000

var global_delta: float

func _ready():
    velocity_gauge = 0
    VelocitySystem.connect("increment_velocity_gauge", increment)
    VelocitySystem.connect("inhibit_velocity_gauge", inhibit)

var flash_counter: float
var reset_counter: float
var do_flash: bool = false

func _process(delta):
    if velocity_gauge >= 1 and reset_counter <= 0:
        if VelocitySystem.velocity_state:
            velocity_gauge -= 7
        else:
            velocity_gauge -= 5

    value = velocity_gauge

    flash_counter += delta

    global_delta = delta

    if reset_counter > 0:
        reset_counter -= delta

    if VelocitySystem.velocity_state:
        if flash_counter > 0.1:
            do_flash = not do_flash
            flash_counter = 0.0

    if not VelocitySystem.velocity_state and velocity_gauge >= velocity_gauge_max - 5:
        VelocitySystem.velocity_state = true
        $Start.play()

    if VelocitySystem.velocity_state and velocity_gauge <= 0:
        VelocitySystem.velocity_state = false

    if do_flash and VelocitySystem.velocity_state:
        self_modulate = Color.SKY_BLUE
    else:
        self_modulate = Color.WHITE

func increment(amount: int):
    if velocity_gauge < velocity_gauge_max:
        velocity_gauge += amount
    keep_from_dropping(2.5)

func inhibit():
    keep_from_dropping(2.001)

func keep_from_dropping(amount: float):
    reset_counter = amount * global_delta
