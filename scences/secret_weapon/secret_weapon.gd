extends RigidBody3D


func _ready():
	freeze = true  # Замораживаем объект

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		freeze = false  # Размораживаем — объект начнет падать
