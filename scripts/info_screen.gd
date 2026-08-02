extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func _on_info_pressed() -> void:
	visible = true if visible == false else false
