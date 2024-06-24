extends Control

@export var title_text = "Title"
@export_multiline var message_text = "Body text body text body text."

@onready var title = $Background/TitleBar/Title
@onready var message = $Background/MessageContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	title.text = title_text
	message.text = message_text
	if visible:
		handle_close_input()

func handle_close_input():
	if Input.is_action_just_pressed("Jump"):
		close_popup()

func _on_close_button_pressed():
	close_popup()

func close_popup():
	$Background/AnimationPlayer.play("hide")
	await($Background/AnimationPlayer.animation_finished)
	hide()
