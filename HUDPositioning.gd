"""
HUDPositioning.gd - Handles the positioning for the BottomHUD Control node.

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

extends Control

func _ready():
	anchor_top = 1
	anchor_bottom = 1
	
	offset_top = -120
	offset_bottom = 0
	offset_left = 40
