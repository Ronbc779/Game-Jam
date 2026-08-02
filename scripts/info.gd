extends TextureButton

func _on_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	AudioMang.stop_bgm()
