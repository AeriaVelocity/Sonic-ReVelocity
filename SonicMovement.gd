"""
SonicMovement.gd - Handles Sonic's movement as well as game-related
functionality for Green Hill Zone Simulator, the high momentum Sonic fan game
that's so awful and lazy it loops back around to being fun.

Copyright (c) 2024 Arsalan "Velocity" Kazmi <sonicspeed848@gmail.com>

This file is part of Green Hill Zone Simulator.

Green Hill Zone Simulator is free software: you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

Green Hill Zone Simulator is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
more details.

You should have received a copy of the GNU General Public License along with
Green Hill Zone Simulator. If not, see <https://www.gnu.org/licenses/>.
"""

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

func toggle_fullscreen():
	var full_screen = DisplayServer.window_get_mode()

	if full_screen:
		DisplayServer.window_set_mode(0)
	else:
		DisplayServer.window_set_mode(4)
		
	print(full_screen)

func update_speed_rank():
	var speedometer: Label = get_node("/root/Game/CanvasLayer/BottomHUD/Speedometer")
	var rank_object: Label = get_node("/root/Game/CanvasLayer/BottomHUD/SpeedRank")
	var rank: String
	var speed = sqrt(velocity.x ** 2 + velocity.y ** 2)
	if dead:
		rank = "You are ded, not big soup rice!"
	elif speed >= 1500:
		rank = "SPEED FASTEST!!!"
	elif speed >= 1000:
		rank = "Now That's What I Call Speed™!"
	elif speed >= 500:
		rank = "That's speed, but it's not speed enough!"
	elif speed >= 60:
		rank = "Come on! Speed up already!"
	else:
		rank = "You're barely even moving!"
	if not dead:
		speedometer.set_text("Speedometer: %d fasts per speed" % speed)
		rank_object.set_text("Speed Rank: " + rank)
	else:
		speedometer.set_text("DEADometer: Yes DEATHS per DEAD")
		rank_object.set_text("DEAD Rank: " + rank)
	
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
		
	update_speed_rank()
	
	if dead:
		return

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_speed
		velocity.x *= 1.3
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

	if Input.is_action_just_pressed("Jump") and is_on_wall():
		handle_wall_jump()
		velocity.y = jump_speed
		jump_sound.play()
	
	if Input.is_action_just_pressed("MoveLeft") or Input.is_action_just_pressed("MoveRight"):
		handle_movement_sound()
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		movement_sound.stop()
	
	if Input.is_action_just_pressed("FullScreen"):
		toggle_fullscreen()

	if velocity.x == 0:
		handle_movement_sound()
		
	if is_on_floor() and not was_on_floor:
		handle_movement_sound()

	was_on_floor = is_on_floor()

	move_and_slide()
	
	current_velocity = velocity

func _on_death_area_body_entered(body):
	if body.is_in_group("Player"):
		dead = true
		death_sound.play()
		velocity.x = 0
		await(death_sound.finished)
		set_position(start_position)
		dead = false
