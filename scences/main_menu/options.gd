extends Button

const CONFIG_PATH = "user://settings.json"

var is_fullscreen := false

func _ready():
	load_or_create_config()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
	update_button_text()
	pressed.connect(_on_pressed)

func load_or_create_config():
	if FileAccess.file_exists(CONFIG_PATH):
		var file = FileAccess.open(CONFIG_PATH, FileAccess.READ)
		if file:
			var text = file.get_as_text()
			var result = JSON.parse_string(text)
			if typeof(result) == TYPE_DICTIONARY and result.has("fullscreen"):
				is_fullscreen = result["fullscreen"] == 1
	else:
		is_fullscreen = true
		save_config()

func save_config():
	var file = FileAccess.open(CONFIG_PATH, FileAccess.WRITE)
	if file:
		var data = {
			"fullscreen": 1 if is_fullscreen else 0
		}
		file.store_string(JSON.stringify(data))

func update_button_text():
	text = "Оконный режим" if is_fullscreen else "Полноэкранный режим"

func _on_pressed():
	is_fullscreen = not is_fullscreen
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if is_fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
	update_button_text()
	save_config()
