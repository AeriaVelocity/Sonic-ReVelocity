# Sonic Re;Velocity

![Sonic Re;Velocity](title-screen.png)

> [!WARNING]
> Sonic Re;Velocity is still very much a work-in-progress. Don't expect any
> form of quality here.

## Overview

Sonic Re;Velocity is a 2D Sonic fan game with a focus on high-speed
momentum-based platforming, continued off an earlier project, known as Green
Hill Zone Simulator, a joke Sonic fan game built for the RAGE 2024 Sonic Fan
Games HQ event.

Sonic Re;Velocity is built in Godot Engine v4.2 and is free software under the
GNU General Public License 3.0, or, at your option, any later version.

## Controls

| **Keyboard** | **Xbox Gamepad** | **Action** |
| --- | --- | --- |
| `←` | `D-Pad ←` | Move left |
| `→` | `D-Pad →` | Move right |
| `↓` | `D-Pad ↓` | Aim down |
| `Z` | `A` | Jump, Wall Jump |
| `X` | `B` | Quick Spin |
| `Esc` | `Menu` | Back to title |

## Move List

* **Jump** - Sonic can jump, granting him height. I feel like I don't have to
explain how a jump works. It's a jump.
* **Wall Jump** - While Sonic is wallbound (touching a wall and not the floor),
he can jump off of it, sending him upward and away from the wall.
* **Quick Spin** - Sonic can perform a quick Spin Dash, boosting his speed or
changing his direction. While aiming down, Quick Spin will be directed down.
For more information, see [Quick Spin Tech](#quick-spin-tech).

## Quick Spin Tech

The Quick Spin is the central movement mechanic in Sonic Re;Velocity. Sonic can
perform a Quick Spin by pressing the Quick Spin button (`X` on keyboard,
`B` on Xbox controller).

This Quick Spin will affect Sonic's movement in various ways, as described
below.

* If Sonic is moving, but not running, the Quick Spin will place Sonic into
running speed immediately, providing an easy way to get moving.
* If Sonic's running, and the held direction is the same, the Quick Spin will
boost Sonic's speed in his running direction by a little bit. Consecutive Quick
Spins can get him to Mach speed very quickly.
* If Sonic's running, and the held direction is the opposite, the Quick Spin will
cause Sonic to immediately change direction, making him begin running the other
way, at the same speed he was already running.
* If Sonic's airborne, and the player is holding down, the Quick Spin will be
aimed directly downwards, sending Sonic straight down towards the floor.
* If Sonic's airborne, moving horizontally, and the player is holding diagonally
down, the Quick Spin will inherit Sonic's current X-velocity, directed towards
the held horizontal direction.

### Controller Notation

This is assuming you're using an Xbox controller, and Sonic is moving right.

If you're on keyboard, replace `B` with `X`. If you're using a PlayStation
controller, replace `B` with `□`.

If Sonic's running left, not right, replace `→` with `←`, and vice versa.

* `B`/`→ B` while walking or jogging - Quick Spin
  * Get Sonic up to running speed immediately.
* `→ B` while running or at Mach speed - Quick Spin Boost
  * Boost Sonic's running speed by a little bit.
* While moving, `← B` - Quick Spin Reversal
  * Change Sonic's direction, sending him running the other way.

* Aerial `↓ B` - Quick Spin Down
  * Cancel Sonic's horizontal velocity and send him straight down.
* Aerial `↘ B` - Quick Spin Comet
  * Send Sonic straight down without cancelling his horizontal velocity.
  * This move is most effective at Mach speed.
* Aerial `↙ B` - Quick Spin Comet Reversal
  * Send Sonic straight down, and change his horizontal velocity to the
    opposite direction.

## Devlog

The video devlog for Sonic Re;Velocity is available on
[YouTube](https://www.youtube.com/playlist?list=PLBVN9inYeKYy7QS9P7kSf6Gc_aZOokCw9https://www.youtube.com/watch?v=VnZ6H0RmH2A).

## Credits, Licence and Legal Whatevers

Sonic Re;Velocity is a project by Arsalan "Aeria" Kazmi (AeriaVelocity).

Sonic Re;Velocity is free software, under the GNU General Public License 3.0.

That basically means you can do what you want with it, but you can't make it
proprietary, not even if you take all the Sonic elements out. It's also a
Sonic fan game, so don't sell it either. We already saw how that turned out
the last time that happened...
