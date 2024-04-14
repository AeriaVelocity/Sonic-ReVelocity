# Sonic Re;Velocity is a project by Arsalan "Aeria" Kazmi (AeriaVelocity).

## Handles inputs, physics, and movement for Sonic the Hedgehog in Sonic Re;Velocity.

extends CharacterBody2D

@export_group("Movement Values")

## The maximum horizontal speed that Sonic can reach. His X-velocity will never
## exceed this value.
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
@export var speed_level_mach = 800.0

## How high Sonic's X-velocity has to be to use the Run animations.
@export var speed_level_run = 400.0

## How high Sonic's X-velocity has to be to use the Jog animations.
@export var speed_level_jog = 200.0

## How high Sonic's X-velocity has to be to use the Walk animations. Any
## X-velocity below this value will fall back to Idle.
@export var speed_level_walk = 0.1

var dead = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var start_position = position
var was_on_floor: bool

@onready var movement_sound = $MovementSound
@onready var jump_sound = $JumpSound
@onready var jump_spin_sound = $JumpSpinSound
@onready var death_sound = $DeathSound
@onready var land_sound = $LandSound

var last_direction: float

var current_velocity = Vector2()

var camera_target
var camera_speed = 150.0

var movement_sound_tick = 0
var footstep_sounds = []

func _ready():
	was_on_floor = is_on_floor()
	for i in range(1, 6):
		var step_sound = load("res://Sounds/footstep/step" + str(i) + ".wav")
		footstep_sounds.append(step_sound)

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
			
func _input(_event):
	if Input.is_action_just_pressed("Start"):
		get_tree().change_scene_to_file("res://title-screen.tscn")

var camera_speed_multiplier: float = 0.1

func set_camera_offset():
	var offset_x = velocity.x * camera_speed_multiplier
	var offset_y = velocity.y * camera_speed_multiplier / 8
	
	# Apply offset based on horizontal velocity
	if abs(velocity.x) > 0:
		$Camera2D.offset.x = offset_x
	else:
		$Camera2D.offset.x = lerp($Camera2D.offset.x, 0.0, camera_speed_multiplier)
	
	# Apply offset based on vertical velocity
	if abs(velocity.y) > 0:
		$Camera2D.offset.y = offset_y
	else:
		$Camera2D.offset.y = lerp($Camera2D.offset.y, 0.0, camera_speed_multiplier)

func _physics_process(delta):
	set_camera_offset()
	
	if not is_on_floor():
		velocity.y += gravity * delta
	get_node("/root/HudScripting").update_speed(velocity)

	if dead:
		return

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		const level_floor_normal = -1 # because Godot said so
		var floor_normal = get_floor_normal()

		var on_slope = floor_normal.y > level_floor_normal
		if on_slope and abs(velocity.x) > 100:
			var slope_bonus = (2.0 + floor_normal.y)
			var speed_bonus = (abs(velocity.x) - 100) / 4
			velocity.y += jump_speed * slope_bonus - speed_bonus
		else:
			velocity.y += jump_speed

		velocity.x *= 1.3
		jump_sound.play()
		jump_spin_sound.play()

	var direction = Input.get_axis("MoveLeft", "MoveRight")
	
	if velocity.x != 0:
		last_direction = velocity.x
	$SonicSprite.flip_h = last_direction < 0

	if direction != 0:
		current_velocity.x = current_velocity.x + direction * acceleration * delta
		current_velocity.x = clamp(current_velocity.x, -speed_cap, speed_cap)
	else:
		if current_velocity.x > 0 and is_on_floor():
			current_velocity.x = max(0, current_velocity.x - deceleration * delta)
		elif current_velocity.x < 0 and is_on_floor():
			current_velocity.x = min(0, current_velocity.x + deceleration * delta)

	velocity.x = current_velocity.x

	if Input.is_action_just_pressed("Jump") and is_on_wall():
		handle_wall_jump()
		velocity.y = jump_speed
		jump_sound.play()

	was_on_floor = is_on_floor()

	move_and_slide()
	
	if is_on_floor() and not was_on_floor:
		land_sound.play()

	var last_collision = get_last_slide_collision()
	if last_collision != null:
		set_grounded_sprite(abs(velocity.x))
		handle_movement_sound(abs(velocity.x))
		$SonicSprite.set_rotation(last_collision.get_normal().x)
	else:
		$SonicSprite.set_rotation(0)
		$SonicSprite.play("jump")

	current_velocity = velocity

func set_grounded_sprite(speed):
	var sprite: StringName

	if speed >= speed_level_mach:
		sprite = "mach"
	elif speed >= speed_level_run:
		sprite = "run"
	elif speed >= speed_level_jog:
		sprite = "jog"
	elif speed >= speed_level_walk:
		sprite = "walk"
	else:
		sprite = "idle"

	$SonicSprite.play(sprite)
