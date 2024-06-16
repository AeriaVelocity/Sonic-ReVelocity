extends Node

# Copyright (c) 2024 Arsalan "Aeria" Kazmi <sonicspeed848@gmail.com>

# ControllerHandling.gd
# A script for Godot Engine 4.2, designed to handle cases of controllers that
# are not actually controllers (for example, touchpads).  This script was
# written to fix issues with controller inputs on Linux with a  Synaptics
# touchpad.

# This file was created for Sonic Re;Velocity, but is not considered "part of"
# it. It may freely be used in other projects.

# To use the functions in this file:
	# 1. Set up an autoload with this script connected to it.
	# 2. Replace all instances of `Input.get_joy_name(0)` with `ControllerHandling.get_real_joy_name()`.
	# 3. Replace all instances of `Input.get_joy_guid(0)` with `ControllerHandling.get_real_joy_guid()`.
	# 4. Enjoy not having touchpads recognised as controllers!

## This function ignores controllers that are not proper controllers and skips
## to the next one in the list of connected joypads, returning the name of the
## actual controller.
## `offset` is provided to offset the index of joypads, to mimic the behaviour
## of providing an argument to `Input.get_joy_name()`.
func get_real_joy_name(offset: int = 0) -> String:
	for joy_index in Input.get_connected_joypads():
		if Input.is_joy_known(joy_index + offset):
			return Input.get_joy_name(joy_index + offset)

	# Returning "" indicates that the user is not using a proper controller.
	# "" is used if no controller is detected, i.e. the user is using a keyboard
	# or a touch device.
	return ""

## This function ignores controllers that are not proper controllers and skips
## to the next one in the list of connected joypads, returning the GUID of the
## actual controller.
## `offset` is provided to offset the index of joypads, to mimic the behaviour
## of providing an argument to `Input.get_joy_guid()`.
func get_real_joy_guid(offset: int = 0) -> String:
	for joy_index in Input.get_connected_joypads():
		if Input.is_joy_known(joy_index + offset):
			return Input.get_joy_guid(joy_index + offset)
	return ""

# Yes, this file is seriously more comments than it is code. Oh well.
