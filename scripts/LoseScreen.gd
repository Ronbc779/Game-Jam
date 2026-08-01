extends Control

@onready var result_label: Label = $ResultLabel

func _ready() -> void:
	result_label.text = GameResult.lose_reason
