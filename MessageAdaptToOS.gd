extends Label

func _ready():
	var base_message = text
	
	var close_key = get_close_key()
	var driver_extension = get_driver_extension()
	
	var platform_specific_message = base_message.replace("{close_key}", close_key).replace("{driver_ext}", driver_extension)
	
	text = platform_specific_message

func get_close_key() -> String:
	match OS.get_name():
		"Windows":
			return "Alt-F4"
		"macOS":
			return "⌘Q"
		"Linux":
			return "Alt-F4 or Ctrl-Q, depends on your WM"
		"Android":
			return "open your app switcher and swipe the app away"
		"Web":
			return "close the tab"
		_:
			return "I'm sure you can figure it out"

func get_driver_extension() -> String:
	match OS.get_name():
		"Windows":
			return "dll"
		"macOS":
			return "kext"
		"Linux":
			return "so"
		"Android":
			return "so"
		"Web":
			return "js"
		_:
			return "driverofsomekind"
