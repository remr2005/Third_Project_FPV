extends Button

func _ready():
	# Подключаем нажатие кнопки к методу выхода
	pressed.connect(on_button_pressed)

func on_button_pressed():
	get_tree().quit()
