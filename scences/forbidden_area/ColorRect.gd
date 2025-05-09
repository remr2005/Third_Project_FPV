extends ColorRect

var fade_speed := 0.1
var alpha := 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alpha < 0.5:
		alpha += fade_speed * delta
		alpha = clamp(alpha, 0.0, 0.5)
		color.a = alpha
