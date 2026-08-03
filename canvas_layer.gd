extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("menu"):
		if visible == false:
			visible = true
		else:
			visible = false

func _on_resume_pressed() -> void:
	visible = false
	
func _on_restart_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	ShopManager.start_new_run()
	get_tree().reload_current_scene()
	AudioMang.stop_bgm()
	
func _on_quit_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	AudioMang.stop_bgm()
