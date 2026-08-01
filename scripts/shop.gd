extends StaticBody2D

@export var shop_ui_path: NodePath
@onready var label: Label = $Label

var player_in_range: bool = false
var shop_open: bool = false
var shop_ui: Control

func _ready() -> void:
	shop_ui = get_node(shop_ui_path)
	print("shop_ui resolved to: ", shop_ui)
	shop_ui.visible = false
	label.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		label.visible = true
		player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		label.visible = false
		player_in_range = false
		if shop_open:
			close_shop()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		print("interact pressed, player_in_range = ", player_in_range)
		if player_in_range:
			if shop_open:
				close_shop()
			else:
				open_shop()

func open_shop() -> void:
	shop_open = true
	shop_ui.visible = true

func close_shop() -> void:
	shop_open = false
	shop_ui.visible = false
