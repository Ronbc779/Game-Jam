extends StaticBody2D

@onready var prompt_label: Label = $PromptLabel
@onready var timer_node: Control = get_node("/root/main/CanvasLayer/timer")

var player_in_range: bool = false

func _ready() -> void:
	prompt_label.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		prompt_label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		prompt_label.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_in_range:
		attempt_departure()

func attempt_departure() -> void:
	var completed: int = ShopManager.checklist_complete_count()
	var total: int = ShopManager.checklist.size()

	if completed == total:
		var minutes_left: int = timer_node.minutes_until_boarding - timer_node.minutes_elapsed
		GameResult.win(minutes_left)
	else:
		GameResult.lose("People are disappointed in you.")
