extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TransitionScreen.transition_enter()
	AudioMang.play_bgm("menuTheme")

func _on_info_scrn_ready() -> void:
	$info_scrn.visible = false

func _on_info_pressed() -> void:
	$info_scrn.visible = true if $info_scrn.visible == false else false
