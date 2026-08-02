extends Camera2D

@export var edge_left_path: NodePath
@export var edge_right_path: NodePath

func _ready() -> void:
	var edge_left: Node2D = get_node(edge_left_path)
	var edge_right: Node2D = get_node(edge_right_path)
	limit_left = int(edge_left.global_position.x)
	limit_right = int(edge_right.global_position.x)
