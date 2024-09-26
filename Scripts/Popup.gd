extends Control

enum PopupType {
    Ok,
    OkCancel,
}

@export var title_text: String = "Title"
@export_multiline var message_text: String = "Body text body text body text.\nThe body text keeps growing."
@export var popup_type: PopupType = PopupType.Ok

@export var ok_label: String = "OK"
@export var cancel_label: String = "Cancel"

@onready var title = $Elements/TitleBar/Title
@onready var message = $Elements/MessageContainer/VBoxContainer/Label
@onready var controls = $Elements/Controls

signal ok_pressed
signal cancel_pressed

func _ready():
    $AlertSound.play()
    $AnimationPlayer.play("show")

func _process(_delta):
    title.text = title_text
    message.text = message_text
    controls.text = get_controls_text()
    if visible and $Elements.modulate == Color.WHITE:
        handle_close_input()

func set_title_text(t: String):
    title_text = t

func set_message_text(m: String):
    message_text = "[center]" + m + "[/center]"

func set_popup_type(t: PopupType):
    popup_type = t

func set_ok_label(l: String):
    ok_label = l

func set_cancel_label(l: String):
    cancel_label = l

func get_controls_text() -> String:
    var controls_text: String
    match popup_type:
        PopupType.Ok:
            controls_text = "{Jump} %s" % ok_label
        PopupType.OkCancel:
            controls_text = "{Jump} %s  {Spin} %s" % [ok_label, cancel_label]
        _:
            controls_text = "There's a bug in the popup system"
    controls_text = PromptHelpers.format_string_tags(controls_text)
    return "[center]" + controls_text + "[/center]"

func handle_close_input():
    match popup_type:
        PopupType.Ok:
            if Input.is_action_just_pressed("Jump") and GameOptions.button_prompts != GameOptions.Buttons.Switch:
                ok_close()
            elif Input.is_action_just_pressed("Spin") and GameOptions.button_prompts == GameOptions.Buttons.Switch:
                ok_close()
        PopupType.OkCancel:
            if Input.is_action_just_pressed("Jump"):
                if GameOptions.button_prompts != GameOptions.Buttons.Switch:
                    ok_close()
                elif GameOptions.button_prompts == GameOptions.Buttons.Switch:
                    cancel_close()
            elif Input.is_action_just_pressed("Spin"):
                if GameOptions.button_prompts == GameOptions.Buttons.Switch:
                    ok_close()
                elif GameOptions.button_prompts != GameOptions.Buttons.Switch:
                    cancel_close()

func ok_close():
    emit_signal("ok_pressed")
    close_popup()

func cancel_close():
    emit_signal("cancel_pressed")
    close_popup()

func close_popup():
    $AnimationPlayer.play("hide")
    await($AnimationPlayer.animation_finished)
    hide()
