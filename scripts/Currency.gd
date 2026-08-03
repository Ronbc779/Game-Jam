extends Node

signal money_changed(new_amount)
signal purchase_success

var money: int = 500

@export var round_to_nearest: int = 50

func randomize_starting_money(min_amount: int, max_amount: int) -> void:
	var raw := randi_range(min_amount, max(max_amount, min_amount))
	money = round_amount(raw)
	if money < min_amount:
		money += round_to_nearest
	money_changed.emit(money)

func round_amount(amount: int) -> int:
	return int(round(float(amount) / round_to_nearest)) * round_to_nearest

func spend(amount: int) -> bool:
	if amount > money:
		return false
	money -= amount
	money_changed.emit(money)
	return true
