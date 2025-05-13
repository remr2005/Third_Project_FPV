extends Node3D

@onready var drone = $Drone
@onready var camera = $Camera3D

# Параметры следования
var follow_speed := 5.0
var ground_y := 0.0  # Y-уровень земли

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000.0
	
	# Луч пересекает плоскость Y = ground_y
	var plane = Plane(Vector3.UP, ground_y)
	var intersection = plane.intersects_ray(from, to)

	if intersection != null:
		var target_position = intersection
		var current_position = drone.global_transform.origin
		var new_position = current_position.lerp(target_position, delta * follow_speed)

		# Применяем новое положение
		var transform = drone.global_transform
		transform.origin = new_position
		drone.global_transform = transform
