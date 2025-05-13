extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var speed = 3600
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$pro1.rotation_degrees.y += speed * delta
	$pro2.rotation_degrees.y += speed * delta
	$pro3.rotation_degrees.y += speed * delta
	$pro4.rotation_degrees.y += speed * delta
