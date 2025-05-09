extends Control

@onready var label = $Label

func update_status(velocity: Vector3, position: Vector3, proc: float):
	var speed = velocity.length()
	var text := "Мощность двигателя: %s %%\nСкорость: %s км/ч\nВертикальная скорость: %s м/с\nВысота: %s м" % [
		str(round(proc * 100.0)),
		str(round(speed*3.6)),
		str(round(velocity.y)),
		str(round(position.y))
	]
	label.text = text

func _ready():
	var font = load("res://fonts/LanaPixel.ttf") as Font
	label.add_theme_font_override("font", font)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
