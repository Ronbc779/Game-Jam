extends Node2D

@onready var buttons:= $Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/Start.alignment = HORIZONTAL_ALIGNMENT_LEFT
	$Control/Info.alignment = HORIZONTAL_ALIGNMENT_LEFT
	$Control/Credits.alignment = HORIZONTAL_ALIGNMENT_LEFT
	$Control/Quit.alignment = HORIZONTAL_ALIGNMENT_LEFT

	TransitionScreen.transition_enter()
	AudioMang.play_bgm("menuTheme")

func _on_info_scrn_ready() -> void:
	$info_scrn.visible = false


func _on_info_pressed() -> void:
	$info_scrn.visible = true if 	$info_scrn.visible == false else false

func _on_start_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	ShopManager.start_new_run()
	AudioMang.stop_bgm()
	
func _on_credits_pressed() -> void:
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
	AudioMang.stop_bgm()
	
func _on_quit_pressed() -> void:
	get_tree().quit()
