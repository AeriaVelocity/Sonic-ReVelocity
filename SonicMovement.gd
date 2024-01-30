extends CharacterBody2D

var speed = 1000.0
var acceleration = 400.0
var deceleration = 200.0
var jump_speed = -500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var start_position = position

@onready var movement_sound = $MovementSound
@onready var jump_sound = $JumpSound
@onready var death_sound = $DeathSound

var current_velocity = Vector2()

var camera_target
var camera_speed = 150.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_speed
		jump_sound.play()

	var direction = Input.get_axis("MoveLeft", "MoveRight")
	
	if direction != 0:
		current_velocity.x = current_velocity.x + direction * acceleration * delta
		current_velocity.x = clamp(current_velocity.x, -speed, speed)
	else:
		if current_velocity.x > 0 and is_on_floor():
			current_velocity.x = max(0, current_velocity.x - deceleration * delta)
		elif current_velocity.x < 0 and is_on_floor():
			current_velocity.x = min(0, current_velocity.x + deceleration * delta)

	velocity.x = current_velocity.x

	if Input.is_action_just_pressed("MoveLeft") or Input.is_action_just_pressed("MoveRight"):
		movement_sound.playing = true

	if Input.is_action_just_released("MoveLeft") or Input.is_action_just_released("MoveRight"):
		movement_sound.playing = false

	move_and_slide()
	
	current_velocity = velocity

func _on_death_area_body_entered(body):
	death_sound.play()
	current_velocity.x = 0
	await(death_sound.finished)
	set_position(start_position)
