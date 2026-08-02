extends TextureButton

func _on_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().reload_current_scene()
	AudioMang.stop_bgm()
	
