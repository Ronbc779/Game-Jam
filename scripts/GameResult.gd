extends Node

var did_win: bool = false
var lose_reason: String = ""

func win() -> void:
	did_win = true
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")

func lose(reason: String) -> void:
	did_win = false
	lose_reason = reason
	get_tree().change_scene_to_file("res://scenes/lose_screen.tscn")
