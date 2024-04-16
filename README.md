# Sonic Re;Velocity

![Sonic Re;Velocity](title-screen.png)

> [!WARNING]
> Sonic Re;Velocity is in the middle of being converted from Green Hill Zone
> Simulator, and in its current state, it still resembles Green Hill Zone
> Simulator quite a bit. For the original version of Green Hill Zone Simulator,
> see [its repository](https://github.com/That1M8Head/GreenHillSimulator).

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
| `Z` | `A` | Jump, Wall Jump |
| `X` | `B` | Quick Spin |
| `Esc` | `Menu` | Back to title |

---

> [!WARNING]
> This section of the README will focus on to-be-implemented mechanics.
> These mechanics will be implemented in the future, but they are not yet
> implemented in the current version of Sonic Re;Velocity.

## Move List

### Movement

* **Spin Dash**
  * *While Sonic is standing,* hold **Crouch** and rapidly press **Jump**, then release **Crouch**
  * Roll into a ball, charge up a spinning attack and dash forward at high speed.
* **Drop Dash**
  * *While Sonic is in ball form mid-air,* hold **Jump** until landing
  * Charge an aerial Spin Dash and dash forward upon touching the ground.
* **Quick Turn**
  * *While Sonic is running,* hold **Direction** in opposite direction and press **Spin**
  * Quickly change directions on a whim with a quick spin attack.
* **Wall Jump**
  * *While Sonic is touching a wall and not the floor,* hold **Direction** towards wall and press **Jump**
  * Jump off of the wall, useful for gaining height or changing direction if you're about to crash into a wall.

### Attacks

* **Bounce Attack**
  * *While Sonic is in the air and in ball form,* hold **Down** and press **Spin**
  * Perform a downward attack that sends you right back up slightly higher.
* **Drop Attack**
  * *While Sonic is in the air,* hold **Down** and press **Attack**
  * Perform a downward attack that shatters through enemy defences.
* **Kick Dash**
  * *While Sonic is running,* press **Attack**
  * Place all your velocity behind a high-speed kick.
* **Somersault**
  * *While Sonic is standing or walking,* press **Spin**
  * Perform a quick somersault, capable of rolling under low ceilings.
* **Sonic Up Draft**
  * *After a Standing Attack,* hold **Direction** in opposite direction and press **Attack**
  * Perform a reverse sweeping kick that knocks enemies into the air.
* **Spin Shot**
  * *While charging Spin Dash,* press **Spin**
  * Use the energy stored in a Spin Dash and put your all into a powerful spin attack.

## Controls

### Keyboard

| Key | Action | Description |
| --- | --- | --- |
| `←` | Move left | Move Sonic left in the game world. |
| `→` | Move right | Move Sonic right in the game world. |
| `↓` | Crouch | Make Sonic crouch. Makes him roll if he's already running. |
| `Z` | Jump | Make Sonic jump. Jumping enters ball state. |
| `X` | Attack | Make Sonic perform a contextual attack. |
| `C` | Spin | Make Sonic perform a quick spin attack. |
| `Esc` | Pause | Pause the game. |

### Gamepad (Xbox)

| Button | Action | Description |
| --- | --- | --- |
| `←` | Move left | Move Sonic left in the game world. |
| `→` | Move right | Move Sonic right in the game world. |
| `↓` | Crouch | Make Sonic crouch. Makes him roll if he's already running. |
| `A` | Jump | Make Sonic jump. Jumping enters ball state. |
| `X` | Attack | Make Sonic perform a contextual attack. |
| `B` | Spin | Make Sonic perform a quick spin attack, letting him change direction. |
| `Menu` | Pause | Pause the game. |

### Touch

| Label | Action | Description |
| --- | --- | --- |
| Left-pointing triangle | Move left | Move Sonic left in the game world. |
| Right-pointing triangle | Move right | Move Sonic right in the game world. |
| Down-pointing triangle | Crouch | Make Sonic crouch. Makes him roll if he's already running. |
| Up-pointing triangle | Jump | Make Sonic jump. Jumping enters ball state. |
| Fist | Attack | Make Sonic perform a contextual attack. |
| Ball | Spin | Make Sonic perform a quick spin attack, letting him change direction. |
| Pause symbol | Pause | Pause the game. |
