extends CanvasLayer

@onready var money_label: Label = $MoneyLabel

func _ready() -> void:
	Currency.money_changed.connect(_on_money_changed)
	_on_money_changed(Currency.money)

func _on_money_changed(new_amount: int) -> void:
	money_label.text = "Cash: ₱%d" % new_amount
