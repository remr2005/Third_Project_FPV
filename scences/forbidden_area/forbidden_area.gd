extends Area3D

var bodies_inside := []
var restart_timer := Timer.new()

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	$ColorRect.visible = false

	# Создаем таймер для отсчета 10 секунд
	restart_timer = Timer.new()
	restart_timer.wait_time = 10
	restart_timer.one_shot = true
	restart_timer.timeout.connect(_on_restart_timeout)
	add_child(restart_timer)

func _on_body_entered(body):
	if body.name == "dron":
		if body not in bodies_inside:
			bodies_inside.append(body)
		$ColorRect.visible = true
		restart_timer.start()

func _process(delta):
	var text := "Время до перезапуска уровня: %s с" % [
			str(round(restart_timer.time_left))
		]
	$ColorRect/TimeLable.text = text

func _on_body_exited(body):
	if body in bodies_inside:
		bodies_inside.erase(body)
	if bodies_inside.is_empty():
		$ColorRect.visible = false
		restart_timer.stop()

func _on_restart_timeout():
	if not bodies_inside.is_empty():
		get_tree().reload_current_scene()
