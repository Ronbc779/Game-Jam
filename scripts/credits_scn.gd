extends ColorRect

func _ready() -> void:
	AudioMang.play_bgm("menuBassPercTheme")

func _on_quit_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	AudioMang.stop_bgm()
