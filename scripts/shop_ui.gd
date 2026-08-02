extends Control

@onready var item_container: Container = $ScrollContainer/ItemContainer
var sell_item_scene: PackedScene = preload("res://scenes/sell_item.tscn")

func populate(category: String, items: Array) -> void:
	for child in item_container.get_children():
		child.queue_free()

	for item in items:
		var row = sell_item_scene.instantiate()
		item_container.add_child(row)
		row.setup(item["name"], item["price"], category)
