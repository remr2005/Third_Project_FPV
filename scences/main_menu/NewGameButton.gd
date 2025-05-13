extends Button

func _ready():
	connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed():
	var save_data = {
		"last_completed_level": "res://scences/tutorial/Tutorial.tscn"
	}

	var file_path = "user://settings.json"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data, "\t"))
		file.close()
	else:
		print("Не удалось сохранить настройки.")

	get_tree().change_scene_to_file("res://scences/tutorial/Tutorial.tscn")
