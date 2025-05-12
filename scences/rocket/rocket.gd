extends CharacterBody3D

@export var turn_speed = 3
var target: Node3D = null
var speed = 30

func _ready():
	# Подключаемся к сигналу области "зрения"
	$Vision3D.connect("body_entered", _on_body_entered)
	$Vision3D.connect("body_exited", _on_body_exited)

func _physics_process(delta):
	velocity = -transform.basis.z * speed

	if target:
		var to_target = (target.global_position - global_position).normalized()
		var forward = -transform.basis.z.normalized()
		var new_dir = forward.lerp(to_target, delta * turn_speed).normalized()
		look_at(global_position + new_dir, Vector3.UP)

	move_and_slide()

	# Проверка столкновений
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "dron":
			collision.get_collider().queue_free()




func _on_body_entered(body):
	if body.name == "dron":
		target = body

func _on_body_exited(body):
	if body == target:
		target = null
