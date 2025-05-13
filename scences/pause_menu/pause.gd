extends Control


func _ready():
	process_mode = 2# Или просто pause_mode = 2

	$CenterContainer/VBoxContainer/continue.pressed.connect(_on_resume_pressed)
	$CenterContainer/VBoxContainer/reset.pressed.connect(_on_restart_pressed)
	$CenterContainer/VBoxContainer/exit.pressed.connect(_on_quit_pressed)

func _on_resume_pressed():
	get_parent().resume_game()

func _on_restart_pressed():
	get_parent().restart_level()

func _on_quit_pressed():
	get_tree().quit()
