extends Control

@onready var result_label: Label = $ResultLabel

func _ready() -> void:
	result_label.text = "You made it home with all your pasalubong!"
