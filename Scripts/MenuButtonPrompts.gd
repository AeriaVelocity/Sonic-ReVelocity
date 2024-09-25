extends RichTextLabel

const GRAPHICS_PATH = "res://Graphics/Info Signs/"

var original_text: String

func _ready():
    original_text = text

func _process(_delta):
    set_text(PromptHelpers.format_string_tags(original_text))
