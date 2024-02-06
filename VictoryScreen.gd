extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	$VictoryMusic.play()
	await($VictoryMusic.finished)
	get_tree().quit()
