extends Node3D

@onready var drone = $dron
@onready var hud = $DroneHud
@onready var tutorial_label = $TutorialLabel

enum TutorialStep {
	SHOW_UP_INSTRUCTION,
	WAIT_FOR_UP,
	SHOW_DOWN_INSTRUCTION,
	WAIT_FOR_DOWN,
	SHOW_TURN_INSTRUCTION,
	WAIT_FOR_TURN,
	SHOW_COLLECT_INSTRUCTION,
	WAIT_FOR_COIN,
	FINISHED
}

var current_step = TutorialStep.SHOW_UP_INSTRUCTION
var time_since_step = 0.0

func _ready():
	#hud.visible = false
	#$CoinsCount.visible = false
	tutorial_label.visible = true
	tutorial_label.text = "Нажмите стрелку вверх, чтобы взлететь."

func _process(delta):
	if not is_instance_valid(drone):
		get_tree().reload_current_scene()
		return

	hud.update_status(drone.linear_velocity, drone.global_transform.origin, drone.proc)

	match current_step:
		TutorialStep.SHOW_UP_INSTRUCTION:
			if is_action_pressed("ui_up"):
				current_step = TutorialStep.SHOW_DOWN_INSTRUCTION
				tutorial_label.text = "Теперь нажмите стрелку вниз, чтобы опуститься. Если вы случайно перевернулись, вы всегда можете перезапустить уровень нажав кнопку P."
		TutorialStep.SHOW_DOWN_INSTRUCTION:
			if is_action_pressed("ui_down"):
				current_step = TutorialStep.SHOW_TURN_INSTRUCTION
				tutorial_label.text = "Теперь взлетите вновь и попробуйте покрутить дрон: WASD или Q/E."
		TutorialStep.SHOW_TURN_INSTRUCTION:
			if is_action_pressed("yaw_left") or is_action_pressed("yaw_right") or is_action_pressed("pitch_up") or is_action_pressed("pitch_down") or is_action_pressed("roll_left") or is_action_pressed("roll_right"):
				current_step = TutorialStep.SHOW_COLLECT_INSTRUCTION
				tutorial_label.text = "Соберите монету, чтобы завершить уровень."

		TutorialStep.SHOW_COLLECT_INSTRUCTION:
			var coins = get_tree().get_nodes_in_group("coins")
			var any_visible = false
			for coin in coins:
				if coin.visible:
					any_visible = true
					break
			if not any_visible:
				current_step = TutorialStep.FINISHED
				close_level()

func is_action_pressed(action: String) -> bool:
	return Input.is_action_just_pressed(action)

func close_level():
	tutorial_label.text = "Уровень пройден! Поздравляем!"
	await get_tree().create_timer(2.0).timeout

	# Сохраняем прогресс
	var save_data = {}
	var file = FileAccess.open("user://settings.json", FileAccess.READ)
	if file:
		save_data = JSON.parse_string(file.get_as_text())
		file.close()

	save_data["last_completed_level"] = "res://scences/level1/level1.tscn"

	file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data, "\t"))
	file.close()

	# Переход к следующей сцене
	get_tree().change_scene_to_file("res://scences/level1/level1.tscn")
