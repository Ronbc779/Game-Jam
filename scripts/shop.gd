extends StaticBody2D

@export var category: String = "toy"
@export var shop_ui_path: NodePath

var player_in_range: bool = false
var shop_open: bool = false
var shop_ui: Control

func _ready() -> void:
	shop_ui = get_node(shop_ui_path)
	shop_ui.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		if shop_open:
			close_shop()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_in_range:
		if shop_open:
			close_shop()
		else:
			open_shop()

func open_shop() -> void:
	shop_open = true
	shop_ui.populate(category, ShopManager.get_shop_items(category))
	shop_ui.visible = true

func close_shop() -> void:
	shop_open = false
	shop_ui.visible = false
