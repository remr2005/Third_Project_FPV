extends Area3D


@onready var audio_stream_player = $AudioStreamPlayer3D 


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body):
	if body.name == "dron":
		queue_free()
		audio_stream_player.play()
