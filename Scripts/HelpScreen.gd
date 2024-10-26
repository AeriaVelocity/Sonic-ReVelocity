extends Control

@onready var music: AudioStreamPlayer = get_node("/root/GlobalAudio/GlobalMusic")

var page_number: int
var page_title: String

# About Sonic Re;Velocity
const PAGE_1 = """Sonic Re;Velocity is a 2D Sonic fan game with a heavy focus on high-speed momentum and stupidly fast platforming, with a simple control style, a unique gameplay style and a strange emphasis on going as fast as hedgehogly possible.

Sonic Re;Velocity features a unique two-button control style for simplicity and accessibility. It's a bit different to the 2D Sonic games you're probably used to.

Sonic Re;Velocity is developed by Arsalan "Aeri" Kazmi (AeriaVelocity), and is free software under the GNU General Public License 3.0, or, at your option, any later version.

[b]Press {Left} and {Right} to flip through the pages of this help manual, or press {mB} to return to the Main Menu.[/b]"""

# Controls Overview
const PAGE_2 = """Sonic Re;Velocity contains very few in-game controls, making the game simple and accessible to a wide range of people.
Here's a list of controls, which will automatically adapt to your controller:

{Left} and {Right} will move Sonic left and right.

{Jump} will make Sonic jump, and {Jump} against a jumpable wall will make Sonic Wall Jump.

{Spin} or {Special1} will make Sonic perform a Quick Spin, boosting his speed or letting him change direction on the fly.

Information on these moves will be expanded upon in the following pages.
[b]Press {Right} to read on.[/b]"""

# Basic Movement
const PAGE_3 = """[b]To move Sonic around the game world, use the {Left} and {Right} buttons.[/b]

Like the classic games, he'll start slow and increase in speed over time, and pressing the opposite direction ({Right} if he's moving left, or {Left} if he's moving right) will slow him down faster.

When Sonic is in the air, {Left} and {Right} will very slightly influence his movement, but this isn't all that useful on its own.

Don't worry - you'll learn how to more effectively influence Sonic's aerial movement later on, and [i]really[/i] take control of the stages."""

# Jumping
const PAGE_4 = """[b]To have Sonic perform a jump, press {Jump}.[/b]

Jumping is a fundamental ability in Sonic Re;Velocity, as it is in most Sonic games.

On the ground, jumping will boost Sonic's momentum very slightly, and on slopes, he'll be able to take advantage of the incline to travel higher and further. The floor, however, is not the only place Sonic's able to jump off.

[b]Press {Jump} while Sonic is clinging onto a wall to perform a Wall Jump.[/b]

Sonic can only Wall Jump off of special jumpable walls - you'll know he's able to Wall Jump if you see his sprite sticking to the wall itself, as opposed to just being in a ball or dropping down."""

# Quick Spin
const PAGE_5 = """[b]Press {Spin} or {Special1} to have Sonic perform the Quick Spin.[/b] Quick Spin will have Sonic perform a lightning-fast Spin Dash to traverse at high speed.

[b]Press {Left}/{Right} + {Spin} opposite Sonic's movement to perform the Quick Spin Reversal,[/b] flipping Sonic's direction of movement without losing speed. This can be used to manipulate Sonic's aerial movement on the fly!

[b]Press {Down} + {Spin} in the air to perform Quick Spin Down, or {DownLeft}/{DownRight} + {Spin} to perform Quick Spin Comet.[/b] Quick Spin Down will send Sonic straight down, while Quick Spin Comet will send him downward at a 45° angle.

This move can make or break a run - performing Quick Spin with correct timing will net you an overall faster level time, but overreliance can result in wasting precious seconds."""

# Velocity Gauge
const PAGE_6 = """The [b]Velocity Gauge[/b] is the large purple gauge at the top left of the game screen, underneath the blue Speed Gauge, with the word [b][i]VELOCITY[/i][/b] on it. It goes up as Sonic runs and continuously goes down over time.

When the Velocity Gauge is full, Sonic enters [b]Velocity State[/b], an empowered state which grants him rapid speed accumulation, uncaps the speed he's able to run at, and increases how high he jumps.

You'll know when Sonic's in Velocity State when you see the Velocity Gauge flashing, and when you see Sonic enveloped by an aura.

Maintaining Velocity State is key to achieving low time and high ranks in Sonic Re;Velocity!"""

# Ranking System
const PAGE_7 = """The ranking system in Sonic Re;Velocity is based mostly on high speed and getting to the goal as fast as possible. There are no enemies in Sonic Re;Velocity, unlike most other games in the series, therefore there's no score value.

Ranks range from the [b]D[/b] Rank to the [b]X[/b] Rank, and higher ranks are achieved by beating levels faster and faster - the X Rank in particular requiring you to obtain most of the level's Rings.

[b]Important:[/b] Sonic Re;Velocity still only has a [i]Test Level[/i], and the rank requirements for that level are hardcoded right now.

When more levels are added, a more modular and robust ranking system will be implemented in the future."""

var pages = [PAGE_1, PAGE_2, PAGE_3, PAGE_4, PAGE_5, PAGE_6, PAGE_7]

func _ready():
    var help_music: AudioStreamMP3 = load("res://Music/help.mp3")
    music.stream = help_music
    music.play()
    page_number = 0

func _process(_delta):
    var back1_pressed = Input.is_action_just_pressed("Spin") and not GameOptions.reverse_a_b
    var back2_pressed = Input.is_action_just_pressed("Jump") and GameOptions.reverse_a_b
    if back1_pressed or back2_pressed:
        get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

    if Input.is_action_just_pressed("MoveLeft"):
        if page_number > 0:
            page_number -= 1
            $MoveSound.play()
    elif Input.is_action_just_pressed("MoveRight"):
        if page_number < pages.size() - 1:
            page_number += 1
            $MoveSound.play()

    match page_number:
        0:
            page_title = "About Sonic Re;Velocity"
        1:
            page_title = "Controls Overview"
        2:
            page_title = "Basic Movement"
        3:
            page_title = "Jumping"
        4:
            page_title = "Quick Spin"
        5:
            page_title = "Velocity Gauge"
        6:
            page_title = "Ranking System"
        _:
            page_title = "To error is computer."

    $Tooltip.text = "Page %d/%d - %s" % [(page_number + 1), pages.size(), page_title]
    $HelpText.original_text = pages[page_number]
