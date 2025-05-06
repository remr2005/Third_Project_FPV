extends CharacterBody3D

const SPEED = 30
const TURN_SPEED = 1  # скорость поворота
const TURN_INTERVAL = 12  # каждые N секунд пытаться повернуть

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var time_since_turn = 0.0
var turn_direction = 0  # -1 = влево, 0 = прямо, 1 = вправо

func _physics_process(delta):
	# Применяем гравитацию
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Таймер маневра
	time_since_turn += delta
	if time_since_turn >= TURN_INTERVAL:
		time_since_turn = 0
		# случайно выбираем поворот: влево, вправо или не поворачивать
		turn_direction = randi() % 3 - 1  # -1, 0, 1

	# Применяем поворот
	if turn_direction != 0:
		rotate_y(deg_to_rad(turn_direction * TURN_SPEED))

	# Движение вперёд по направлению
	var forward = transform.basis.x.normalized()
	velocity.x = forward.x * SPEED
	velocity.z = forward.z * SPEED

	move_and_slide()
