extends CharacterBody2D

var speed_cap = 2000.0
var acceleration = 400.0
var deceleration = 200.0
var jump_speed = -500.0
var wall_jump_speed = 350.0

var dead = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var start_position = position
var was_on_floor: bool

@onready var movement_sound = $MovementSound
@onready var jump_sound = $JumpSound
@onready var death_sound = $DeathSound

var current_velocity = Vector2()

var camera_target
var camera_speed = 150.0
		
func handle_movement_sound():
	movement_sound.playing = abs(velocity.x) > 0 and is_on_floor()
	
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

func _ready():
	was_on_floor = is_on_floor()

func _physics_process(delta):
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

	var direction = Input.get_axis("MoveLeft", "MoveRight")
	
	var is_rolling = Input.is_action_pressed("Spin") and is_on_floor()

	if is_rolling:
		$SonicSprite.rotate(velocity.x if velocity.x != 0 else 0 / 100.0)

	if direction != 0 and not is_rolling:
		current_velocity.x = current_velocity.x + direction * acceleration * delta
		current_velocity.x = clamp(current_velocity.x, -speed_cap, speed_cap)
	else:
		if current_velocity.x > 0 and is_on_floor() and not is_rolling:
			current_velocity.x = max(0, current_velocity.x - deceleration * delta)
		elif current_velocity.x < 0 and is_on_floor() and not is_rolling:
			current_velocity.x = min(0, current_velocity.x + deceleration * delta)

	velocity.x = current_velocity.x

	if Input.is_action_just_pressed("Jump") and is_on_wall():
		handle_wall_jump()
		velocity.y = jump_speed
		jump_sound.play()
	
	if Input.is_action_just_pressed("MoveLeft") or Input.is_action_just_pressed("MoveRight"):
		handle_movement_sound()
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		movement_sound.stop()

	if velocity.x == 0:
		handle_movement_sound()
		
	if is_on_floor() and not was_on_floor:
		handle_movement_sound()

	was_on_floor = is_on_floor()

	move_and_slide()

	if not is_rolling:
		var last_collision = get_last_slide_collision()
		if last_collision != null:
			$SonicSprite.set_rotation(last_collision.get_normal().x)
		else:
			$SonicSprite.rotate(50 * delta * (velocity.x / abs(velocity.x) if velocity.x != 0 else 1))

	current_velocity = velocity
