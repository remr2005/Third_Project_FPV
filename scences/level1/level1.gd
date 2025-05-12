extends Node3D

@onready var drone = $dron
@onready var hud = $dron_hud

func _process(delta):
	# Проверка на уничтожение дрона
	if not is_instance_valid(drone):
		get_tree().reload_current_scene()
	else:
		hud.update_status(drone.linear_velocity, drone.global_transform.origin, drone.proc)

	# Проверка на отсутствие видимых Coin'ов
	if get_tree() != null:
		var coins = get_tree().get_nodes_in_group("coins")
		var any_visible = false
		for coin in coins:
			if coin.visible:
				any_visible = true
				break
		if not any_visible:
			close_level()


func close_level():
	# Пример завершения уровня — можно заменить на что угодно (переход к сцене и т.д.)
	print("Уровень пройден!")
	get_tree().quit()  # если нужно просто закрыть игру
