extends StaticBody2D

var player_in_range: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_in_range:
		attempt_departure()

func attempt_departure() -> void:
	if ShopManager.checklist_complete_count() == ShopManager.checklist.size():
		GameResult.win()
	else:
		GameResult.lose("People are disappointed in you.")
