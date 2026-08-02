extends Node2D

var departure_area: Node2D = null

func _ready() -> void:
	visible = false
	ShopManager.checklist_updated.connect(_check_completion)
	_check_completion()

func _check_completion() -> void:
	if ShopManager.checklist_complete_count() == ShopManager.checklist.size():
		_find_departure_area()
		visible = true
	else:
		visible = false

func _find_departure_area() -> void:
	if departure_area == null:
		var found = get_tree().get_nodes_in_group("departure")
		if not found.is_empty():
			departure_area = found[0]

func _process(_delta: float) -> void:
	if not visible or departure_area == null:
		return
	var direction := global_position.direction_to(departure_area.global_position)
	rotation = direction.angle()
