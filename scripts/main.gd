extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_timer_pm_check(pm_check: bool) -> void:
	if pm_check:
		AudioMang.play_bgm("nightTheme")
	else: 
		AudioMang.play_bgm("dayTheme")
