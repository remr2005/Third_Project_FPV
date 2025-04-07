extends RigidBody3D


func _ready():
	freeze = true  # Замораживаем объект

#func _process(delta):
	#if Input.is_action_just_pressed("ui_accept"):
		#freeze = false  # Размораживаем — объект начнет падать

func detach_from_parent():
	var global_pos = global_transform

	var root = get_tree().current_scene
	get_parent().remove_child(self)
	root.add_child(self)

	global_transform = global_pos
	if self is RigidBody3D:
		freeze = false
