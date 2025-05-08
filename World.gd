extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var drone = $dron
@onready var hud = $dron_hud

func _process(delta):
	hud.update_status(drone.velocity, drone.global_transform.origin, drone.proc)
