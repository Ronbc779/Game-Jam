extends VBoxContainer

var requirement_row_scene: PackedScene = preload("res://scenes/requirement_row.tscn")

@export var row_height: int = 80    
@export var max_visible_rows: int = 3
@onready var scroll_container: ScrollContainer = get_parent()  # this VBoxContainer must be INSIDE a ScrollContainer

func _ready() -> void:
	ShopManager.checklist_updated.connect(refresh)
	refresh()

func refresh() -> void:
	for child in get_children():
		child.queue_free()

	for entry in ShopManager.checklist:
		var row = requirement_row_scene.instantiate()
		add_child(row)

		var message: String
		if entry["bought"]:
			message = "Got it: %s ✔" % entry["item_name"]
		else:
			message = entry["message"]

		row.setup(entry["person"], message, entry["avatar"], entry["bought"])

	_update_scroll_size(ShopManager.checklist.size())

func _update_scroll_size(entry_count: int) -> void:
	var visible_rows: int = min(entry_count, max_visible_rows)
	scroll_container.custom_minimum_size.y = visible_rows * row_height
