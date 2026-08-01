extends StaticBody2D

@export var category: String = "toy"
@export var shop_ui_path: NodePath

@onready var prompt_label: Label = $Label

var player_in_range: bool = false
var shop_open: bool = false
var shop_ui: Control

func _ready() -> void:
	shop_ui = get_node(shop_ui_path)
	shop_ui.visible = false
	prompt_label.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		prompt_label.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		prompt_label.visible = false
		if shop_open:
			close_shop()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_in_range:
		if shop_open:
			close_shop()
		else:
			AudioMang.play_sfx("openSFX")
			open_shop()

func open_shop() -> void:
	shop_open = true
	var items = ShopManager.get_shop_items(category)
	if items.is_empty():
		print("WARNING: no items found for category '", category, "' — check spelling against ShopManager.shops")
	shop_ui.populate(category, items)
	shop_ui.visible = true
	prompt_label.visible = false

func close_shop() -> void:
	shop_open = false
	shop_ui.visible = false
	if player_in_range:
		prompt_label.visible = true
