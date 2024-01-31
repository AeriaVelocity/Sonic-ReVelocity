extends CharacterBody2D

var speed_cap = 1500.0
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

func update_speed_rank(speed):
	var speedometer: Label = get_node("/root/Node2D/CanvasLayer/Speedometer")
	var rank_object: Label = get_node("/root/Node2D/CanvasLayer/SpeedRank")
	var rank: String
	if speed < 0:
		speed = -speed
	if speed >= 1500:
		rank = "SPEED FASTEST!!!"
	elif speed >= 1000:
		rank = "Now That's What I Call Speed™!"
	elif speed >= 500:
		rank = "That's speed, but it's not speed enough!"
	elif speed >= 60:
		rank = "Come on! Speed up already!"
	else:
		rank = "You're barely even moving!"
	speedometer.set_text("Speedometer: %d fasts per speed" % speed)
	rank_object.set_text("Speed Rank: " + rank)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_speed
		jump_sound.play()

	var direction = Input.get_axis("MoveLeft", "MoveRight")
	
	if direction != 0:
		current_velocity.x = current_velocity.x + direction * acceleration * delta
		current_velocity.x = clamp(current_velocity.x, -speed_cap, speed_cap)
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
	update_speed_rank(velocity.x)
	
	current_velocity = velocity

func _on_death_area_body_entered(body):
	death_sound.play()
	current_velocity.x = 0
	await(death_sound.finished)
	set_position(start_position)
