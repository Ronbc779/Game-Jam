extends CanvasLayer

@onready var money_label: Label = $MoneyLabel  # <-- fix this path to match your actual tree

func _ready() -> void:
	Currency.money_changed.connect(_on_money_changed)
	_on_money_changed(Currency.money)  # show current value immediately on load

func _on_money_changed(new_amount: int) -> void:
	money_label.text = "Cash: ₱%d" % new_amount
