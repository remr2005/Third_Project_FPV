extends Button

func _ready():
	connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed():
	var file_path = "user://settings.json"
	var level_to_load = "res://scences/tutorial/Tutorial.tscn" # значение по умолчанию

	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			var parsed = JSON.parse_string(content)
			if parsed is Dictionary and parsed.has("last_completed_level"):
				var level_name = parsed["last_completed_level"]
				level_to_load = level_name
			file.close()
		else:
			print("Ошибка открытия файла настроек.")
	else:
		print("Файл настроек не найден, загружается tutorial.")

	get_tree().change_scene_to_file(level_to_load)

