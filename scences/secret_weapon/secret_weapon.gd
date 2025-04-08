extends RigidBody3D


func _ready():
	freeze = true  # Замораживаем объект
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Leopard" or body.is_in_group("Leopard"):
		# Создаём взрыв (по желанию можно тут добавить эффект, звук и т.п.)
		print("Boom! Tank hit.")

		# Удаляем оба объекта
		body.queue_free()
		self.queue_free()

func detach_from_parent():
	var global_pos = global_transform

	var root = get_tree().current_scene
	get_parent().remove_child(self)
	root.add_child(self)

	global_transform = global_pos
	if self is RigidBody3D:
		freeze = false
