# Sonic Re;Velocity is a project by Arsalan "Aeria" Kazmi (AeriaVelocity).

## Handles inputs, physics, and movement for Sonic the Hedgehog in Sonic Re;Velocity.

extends CharacterBody2D

@export_group("Movement Values")

## The maximum horizontal speed that Sonic can reach. His X-velocity will never
## exceed this value unless he's in Velocity State.
@export var speed_cap: float = 2000.0

## How fast Sonic gains horizontal speed when moving, capped at [member
## speed_cap].
@export var acceleration: float = 300.0

## How fast Sonic loses horizontal speed when the player lets go of all movement
## controls.
@export var deceleration: float = 200.0

## The Y-velocity force applied to Sonic when jumping. Lower negative values
## will result in more upward force due to how Godot Engine handles physics.
## Similarly, a positive value will result in Sonic jumping [i]downwards[/i], so
## don't do that.
@export var jump_speed: float = -500.0

## The diagonal force applied to Sonic when jumping off of a wall.
## Unlike [member jump_speed], the vertical value is positive-up - a positive
## value will result in an upward force.
@export var wall_jump_speed: float = 350.0

## Groups together thresholds for different grounded movement sprites depending
## on Sonic's X-velocity.
@export_group("Sprite Thresholds", "speed_level_")

## How high Sonic's X-velocity has to be to use the Mach animations.
@export var speed_level_mach = 1000.0

## How high Sonic's X-velocity has to be to use the Run animations.
@export var speed_level_run = 400.0

## How high Sonic's X-velocity has to be to use the Jog animations.
@export var speed_level_jog = 200.0

## How high Sonic's X-velocity has to be to use the Walk animations. Any
## X-velocity below this value will fall back to Idle.
@export var speed_level_walk = 0.1

var dead = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var movement_sound = $MovementSound
@onready var jump_sound = $JumpSound
@onready var jump_spin_sound = $JumpSpinSound
@onready var spin_sound = $SpinSound
@onready var launch_sound = $LaunchSound
@onready var death_sound = $DeathSound
@onready var land_sound = $LandSound

var start_position = position
var was_on_floor: bool
var last_direction: float
var did_jump: bool
var is_dead: bool

var current_velocity = Vector2()

var camera_target
var camera_speed = 150.0

var movement_sound_tick = 0
var footstep_sounds = []

func _ready():
    was_on_floor = is_on_floor()
    did_jump = false
    for i in range(1, 6):
        var step_sound = load("res://Sounds/footstep/step" + str(i) + ".wav")
        footstep_sounds.append(step_sound)

func inc_velocity_gauge(speed):
    if speed >= speed_level_mach:
        VelocitySystem.increment_velocity_gauge.emit(5)
    elif speed >= speed_level_run:
        VelocitySystem.increment_velocity_gauge.emit(3)
    elif abs(velocity.y) >= 80:
        VelocitySystem.inhibit_velocity_gauge.emit()

func handle_movement_sound(speed):
    if not is_on_floor() or speed < speed_level_walk:
        return

    movement_sound_tick += 1

    var sound_delay: float
    var sound_volume: float

    if speed >= speed_level_mach:
        sound_volume = 2.0
        sound_delay = 7
    elif speed >= speed_level_run:
        sound_volume = 6.0
        sound_delay = 10
    elif speed >= speed_level_jog:
        sound_volume = 8.0
        sound_delay = 20
    elif speed >= speed_level_walk:
        sound_volume = 8.0
        sound_delay = 30

    if movement_sound_tick >= sound_delay:
        var sound_index = randi() % footstep_sounds.size()
        var selected_sound = footstep_sounds[sound_index]
        movement_sound.set_stream(selected_sound)
        movement_sound.set_volume_db(sound_volume)
        movement_sound.play()
        movement_sound_tick = 0

func handle_wall_jump():
    if is_on_floor():
        return
    move_and_slide()
    if get_last_slide_collision():
        var collision_normal = get_last_slide_collision().get_normal()

        if collision_normal.x < 0:
            velocity.x = -wall_jump_speed
        elif collision_normal.x > 0:
            velocity.x = wall_jump_speed

func is_pressed_against_wall() -> bool:
    if get_last_slide_collision() and is_on_wall_only() and check_wall_jumpable():
        var collision_normal = get_last_slide_collision().get_normal()
        var direction = Input.get_axis("MoveLeft", "MoveRight")

        if collision_normal.x < 0 and direction == 1:
            return true
        elif collision_normal.x > 0 and direction == -1:
            return true
        else:
            return false
    return false

func do_quick_spin(base_speed, additional_speed) -> Vector2:
    if $SonicSprite.animation == "spin":
        return velocity

    var direction = Input.get_axis("MoveLeft", "MoveRight")
    var current_speed = abs(velocity.x)
    var current_direction = -1 if velocity.x < 0 else 1

    if direction == 0:
        direction = current_direction
        additional_speed *= 1.4

    $SonicSprite.play("spin")
    spin_sound.play()

    await(get_tree().create_timer(0.2).timeout)

    spin_sound.stop()
    launch_sound.play()

    $SonicSprite.offset.y = 0.0
    $SonicSprite.play("run")

    var spin_speed = base_speed if current_speed < base_speed else current_speed + additional_speed
    if sign(direction) != current_direction:
        spin_speed = current_speed
    var directed_speed = spin_speed * direction if direction != 0 else spin_speed * current_direction

    return Vector2(directed_speed, velocity.y)

## Contains functionality for Quick Spin Down and Quick Spin Comet
func quick_spin_down(down_speed) -> Vector2:
    $SonicSprite.play("ball")
    spin_sound.play()

    await(get_tree().create_timer(0.2).timeout)

    spin_sound.stop()
    launch_sound.play()

    $SonicSprite.offset.y = 0.0
    $SonicSprite.play("jump")

    var direction = sign(Input.get_axis("MoveLeft", "MoveRight"))

    var directed_speed = 0
    var base_directed_speed = clamp(abs(velocity.length()), speed_level_run, speed_cap)
    if direction == 0:
        # Quick Spin Down
        directed_speed = 0
    elif direction > 0:
        # Quick Spin Comet
        directed_speed = base_directed_speed
        down_speed = base_directed_speed
    else:
        # Quick Spin Comet Reversal
        directed_speed = -base_directed_speed
        down_speed = base_directed_speed

    return Vector2(directed_speed, down_speed)

var camera_speed_multiplier: float = 0.2

func set_camera_offset(delta):
    var offset_x = velocity.x * camera_speed_multiplier / 3.5
    var offset_y = velocity.y * camera_speed_multiplier / 12

    $Camera2D.position_smoothing_enabled = GameOptions.camera_smoothing

    if abs(velocity.x) > 0:
        $Camera2D.offset.x = offset_x
    else:
        $Camera2D.offset.x = lerp($Camera2D.offset.x, 0.0, camera_speed_multiplier)

    var zoom_speed = 8.0
    var desired_zoom: Vector2

    if abs(velocity.x) >= speed_level_mach:
        desired_zoom = Vector2(2.5, 2.5)
    elif abs(velocity.x) >= speed_level_run:
        desired_zoom = Vector2(3, 3)
    else:
        desired_zoom = Vector2(4, 4)

    $Camera2D.zoom = lerp($Camera2D.zoom, desired_zoom, zoom_speed * delta)

    if abs(velocity.y) > 0:
        $Camera2D.offset.y = offset_y
    else:
        $Camera2D.offset.y = lerp($Camera2D.offset.y, 0.0, camera_speed_multiplier)

func check_wall_jumpable() -> bool:
    var wall_is_jumpable = false
    var last_slide_collision = get_last_slide_collision()

    if last_slide_collision:
        wall_is_jumpable = last_slide_collision.get_collider().is_in_group("WallJump")

    return wall_is_jumpable

func _process(_delta):
    $BoostSprite.visible = VelocitySystem.velocity_state
    $BoostSprite.rotation = velocity.angle()

func create_boost_trail():
    var trail = Sprite2D.new()
    var sprite = $SonicSprite.sprite_frames.get_frame_texture($SonicSprite.animation, $SonicSprite.frame)
    trail.texture = load(sprite.get_path())
    trail.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
    trail.position = position
    trail.modulate = Color(1, 1, 1, 0.6)
    trail.flip_h = $SonicSprite.flip_h
    trail.show_behind_parent = true
    get_parent().add_child(trail)

    var timer = Timer.new()
    timer.one_shot = true
    timer.wait_time = 0.15
    timer.timeout.connect(trail.queue_free)
    get_parent().add_child(timer)
    timer.start()

func _physics_process(delta):
    set_camera_offset(delta)
    inc_velocity_gauge(abs(velocity.x))

    if VelocitySystem.velocity_state and abs(velocity) > Vector2.ZERO:
        create_boost_trail()

    if is_dead:
        return

    if not is_on_floor():
        if is_pressed_against_wall():
            velocity.y = 0
        else:
            velocity.y += gravity * delta
    get_node("/root/HudScripting").update_speed(velocity)

    if dead:
        return

    if Input.is_action_just_pressed("Jump") and is_on_floor() and $SonicSprite.animation != "spin":
        did_jump = true
        const level_floor_normal = -1 # because Godot said so
        var floor_normal = get_floor_normal()

        var velocity_state_bonus = -250 if VelocitySystem.velocity_state else 0
        var on_slope = floor_normal.y > level_floor_normal
        if on_slope and abs(velocity.x) > 100:
            var slope_bonus = (2.0 + floor_normal.y)
            var speed_bonus = (abs(velocity.x) - 100) / 4
            velocity.y += (jump_speed + velocity_state_bonus) * slope_bonus - speed_bonus
        else:
            velocity.y += jump_speed + velocity_state_bonus

        velocity.x *= 1.3
        jump_sound.play()
        jump_spin_sound.play()

    var direction = Input.get_axis("MoveLeft", "MoveRight")

    if velocity.x != 0:
        last_direction = velocity.x
    $SonicSprite.flip_h = last_direction < 0

    if direction != 0:
        var velocity_state_multiplier = 2.5 if VelocitySystem.velocity_state else 1.0
        current_velocity.x = current_velocity.x + direction * acceleration * velocity_state_multiplier * delta
        if not VelocitySystem.velocity_state:
            current_velocity.x = clamp(current_velocity.x, -speed_cap, speed_cap)
        if is_on_floor() and (current_velocity.x < 0 and direction > 0 or current_velocity.x > 0 and direction < 0):
            current_velocity.x /= 1.05
    else:
        if current_velocity.x > 0 and is_on_floor():
            current_velocity.x = max(0, current_velocity.x - deceleration * delta)
        elif current_velocity.x < 0 and is_on_floor():
            current_velocity.x = min(0, current_velocity.x + deceleration * delta)

    velocity.x = current_velocity.x

    if Input.is_action_just_pressed("Jump") and is_on_wall_only() and check_wall_jumpable():
        did_jump = true
        handle_wall_jump()
        velocity.y = jump_speed
        jump_sound.play()

    was_on_floor = is_on_floor()

    var down_direction = Input.is_action_pressed("Crouch")

    if Input.is_action_just_pressed("Spin") and down_direction and not is_on_floor():
        did_jump = true
        velocity = await(quick_spin_down(speed_level_mach))

    if Input.is_action_just_pressed("Spin"):
        did_jump = false
        if direction < 0:
            $SonicSprite.flip_h = true
        elif direction > 0:
            $SonicSprite.flip_h = false
        velocity = await(do_quick_spin(speed_level_run, 120))

    move_and_slide()

    set_rotation(get_floor_normal().x)

    if is_on_floor() and not was_on_floor:
        land_sound.play()
        did_jump = false

    var last_collision = get_last_slide_collision()
    if last_collision:
        if set_movement_sprite(abs(velocity.x)):
            handle_movement_sound(abs(velocity.x))
    else:
        $SonicSprite.set_rotation(0)
        if did_jump:
            $SonicSprite.play("jump")
        else:
            set_movement_sprite(abs(velocity.x))

    current_velocity = velocity

func handle_wallbound_offset(offset_pos: int, offset_neg: int):
    if is_on_wall_only() and check_wall_jumpable():
        var collision_normal = get_last_slide_collision().get_normal()
        if collision_normal.x < 0:
            $SonicSprite.flip_h = true
            $SonicSprite.offset.x = offset_pos
        elif collision_normal.x > 0:
            $SonicSprite.flip_h = false
            $SonicSprite.offset.x = offset_neg
    else:
        $SonicSprite.offset.x = 0

func set_movement_sprite(speed) -> bool:
    var sprite: StringName

    if $SonicSprite.animation == "spin":
        return false

    handle_wallbound_offset(4, -5)

    if is_on_wall_only() and check_wall_jumpable():
        sprite = "wallbound"
    elif speed >= speed_level_mach:
        sprite = "mach"
    elif speed >= speed_level_run:
        sprite = "run"
    elif not is_on_floor():
        if did_jump:
            sprite = "ball"
        else:
            sprite = "drop"
    elif speed >= speed_level_jog:
        sprite = "jog"
    elif speed >= speed_level_walk:
        sprite = "walk"
    elif Input.is_action_pressed("Crouch") and is_on_floor():
        sprite = "crouch"
    else:
        sprite = "idle"

    $SonicSprite.play(sprite, 1.0, true)
    return true

func die():
    is_dead = true
    $DeathSound.play()
    await(get_tree().create_timer(0.5).timeout)
    is_dead = false
    did_jump = false
    LevelStats.rings = 0
    VelocitySystem.velocity_gauge = 0
    position = start_position
    velocity = Vector2(0, 0)
    move_and_slide()
