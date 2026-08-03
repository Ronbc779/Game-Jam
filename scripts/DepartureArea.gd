extends StaticBody2D

@onready var prompt_label: Label = $PromptLabel
@onready var timer_node: Control = get_node("/root/main/CanvasLayer/timer")

@export var edge_left_path: NodePath
@export var edge_right_path: NodePath
@export var edge_margin: float = 200.0

var player_in_range: bool = false

func _ready() -> void:
	add_to_group("departure")
	prompt_label.visible = false
	_spawn_near_random_edge()

func _spawn_near_random_edge() -> void:
	var edge_left: Node2D = get_node(edge_left_path)
	var edge_right: Node2D = get_node(edge_right_path)
	var level_min_x: float = edge_left.global_position.x
	var level_max_x: float = edge_right.global_position.x

	var spawn_on_right: bool = randf() < 0.5
	if spawn_on_right:
		global_position.x = randf_range(level_max_x - edge_margin, level_max_x)
	else:
		global_position.x = randf_range(level_min_x, level_min_x + edge_margin)

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
