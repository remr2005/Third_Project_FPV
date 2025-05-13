extends Area3D


@onready var audio_stream_player = $AudioStreamPlayer


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body):
	if body.name == "dron":
		audio_stream_player.play()
		visible = false
