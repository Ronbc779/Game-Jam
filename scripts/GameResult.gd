extends Node

var did_win: bool = false
var lose_reason: String = ""
var final_score: int = 0

func win(minutes_left: int = 0) -> void:
	did_win = true
	final_score = ShopManager.calculate_score(minutes_left)
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")

func lose(reason: String) -> void:
	did_win = false
	lose_reason = reason
	final_score = ShopManager.calculate_score(0)
	get_tree().change_scene_to_file("res://scenes/lose_screen.tscn")

func restart() -> void:
	ShopManager.start_new_run()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
