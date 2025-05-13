extends Node3D

@onready var drone = $dron
@onready var hud = $dron_hud
@onready var esc_menu = $Pause

func _ready():
	esc_menu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


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


func _input(event):
	if event.is_action_pressed("ui_cancel"): # ESC по умолчанию
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		resume_game()
	else:
		pause_game()

func pause_game():
	get_tree().paused = true
	esc_menu.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func resume_game():
	get_tree().paused = false
	esc_menu.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func restart_level():
	toggle_pause()
	drone.queue_free()
