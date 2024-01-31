"""
ring_pickup.gd - Handles functionality for the Ring pickups in Green Hill Zone
Simulator.

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

extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Player")
	$RingSprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var ring_sound = $RingSound
		ring_sound.play()
		hide()
		await(ring_sound.finished)
		queue_free()
