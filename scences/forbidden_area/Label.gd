extends Label

var time := 0.0
var amplitude := 1.0  # Насколько сильно качается
var speed := 1.0      # Частота

func _process(delta):
	time += delta
	position.y += sin(time * speed) * amplitude
	position.x += cos(time * speed) * amplitude

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
