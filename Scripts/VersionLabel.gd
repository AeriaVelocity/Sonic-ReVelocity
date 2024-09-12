extends Label

@onready var game_version = ProjectSettings.get_setting("application/config/version")

func get_ordinal(number: int) -> String:
    var suffix = "th"

    if number % 100 in [11, 12, 13]:
        suffix = "th"
    else:
        match number % 10:
            1:
                suffix = "st"
            2:
                suffix = "nd"
            3:
                suffix = "rd"

    return str(number) + suffix

func _process(_delta):
    var rev_number = int(game_version.split(".")[0])
    var revolution = get_ordinal(rev_number)

    text = "v%s (%s Revolution)" % [game_version, revolution]
