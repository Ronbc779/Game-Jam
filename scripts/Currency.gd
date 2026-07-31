extends Node

signal money_changed(new_amount)

var money: int = 500

func _ready() -> void:
	money = randi_range(300, 800)
	money_changed.emit(money)

func spend(amount: int) -> bool:
	if amount > money:
		return false
	money -= amount
	money_changed.emit(money)
	return true
