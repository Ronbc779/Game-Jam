extends VBoxContainer

var requirement_row_scene: PackedScene = preload("res://scenes/requirement_row.tscn")

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
