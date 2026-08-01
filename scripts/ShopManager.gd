extends Node

signal checklist_updated

var shops: Dictionary = {
	"toy": {
		"items": [
			{"name": "Wooden Yoyo", "price": 100},
			{"name": "Lato-lato", "price": 180},
			{"name": "Sungka Set", "price": 250},
		]
	},
	"souvenir": {
		"items": [
			{"name": "Keychain", "price": 80},
			{"name": "Fridge Magnet", "price": 60},
			{"name": "Pututoy", "price": 150},
		]
	},
	"food": {
		"items": [
			{"name": "Bukopie",  "price": 100},
			{"name": "Tunapie",  "price": 200},
			{"name": "Applepie", "price": 300},
			{"name": "Otap",     "price": 90},
		]
	},
}

var people_pool: Array = [
	{"name": "Tita Baby", "avatar": preload("res://icon.svg")},
	{"name": "Sharmaine", "avatar": preload("res://icon.svg")},
	{"name": "Girlie", "avatar": preload("res://icon.svg")},
	{"name": "Panying", "avatar": preload("res://icon.svg")},
	{"name": "Ate Grace", "avatar": preload("res://icon.svg")},
]

var requirement_types_pool: Array = [
	{"type": "category", "value": "toy"},
	{"type": "category", "value": "souvenir"},
	{"type": "category", "value": "food"},
	{"type": "item", "value": "Bukopie"},
	{"type": "item", "value": "Sungka Set"},
	{"type": "item", "value": "Pututoy"},
	{"type": "item", "value": "Tunapie"},
	{"type": "item", "value": "Wooden Yoyo"},
	{"type": "item", "value": "Keychain"},
	{"type": "item", "value": "Applepie"},
	{"type": "item", "value": "Lato-lato"},
	{"type": "item", "value": "Fridge Magnet"},
]

var category_message_templates: Array = [
	"Pwede paki bilhan ako ng {value}?",
	"Wag kalimutan yung {value} ha!",
	"Gusto ko sana ng {value} pasalubong.",
	"{value} lang, kahit ano basta {value}.",
]
var item_message_templates: Array = [
	"Yung {value} lang talaga gusto ko!",
	"Wag kang uuwi kung wala kang {value}.",
	"Sabi ko sayo, {value} lang ha!",
]

var checklist: Array = []

func _ready() -> void:
	start_new_run()

func start_new_run() -> void:
	var req_pool: Array = requirement_types_pool.duplicate(true)
	req_pool.shuffle()

	var people: Array = people_pool.duplicate(true)
	people.shuffle()

	var requirement_count: int = randi_range(3, 5)
	requirement_count = min(requirement_count, req_pool.size(), people.size())

	checklist.clear()
	for i in requirement_count:
		var req = req_pool[i]
		var person = people[i]

		var template: String
		if req["type"] == "category":
			template = category_message_templates.pick_random()
		else:
			template = item_message_templates.pick_random()
		var message: String = template.replace("{value}", req["value"])

		checklist.append({
			"type": req["type"],
			"value": req["value"],
			"person": person["name"],
			"avatar": person["avatar"],
			"message": message,
			"bought": false,
			"item_name": "",
			"price_paid": 0,
		})

	checklist_updated.emit()

	var min_cost: int = _minimum_required_cost()
	var spending_buffer: int = 750
	Currency.randomize_starting_money(min_cost, min_cost + spending_buffer)

func _minimum_required_cost() -> int:
	var total := 0
	for entry in checklist:
		if entry["type"] == "item":
			total += _price_of_item(entry["value"])
		else:
			total += _cheapest_price_in_category(entry["value"])
	return total

func _price_of_item(item_name: String) -> int:
	for category in shops.keys():
		for item in shops[category]["items"]:
			if item["name"] == item_name:
				return item["price"]
	return 0

func _cheapest_price_in_category(category: String) -> int:
	if not shops.has(category):
		return 0
	var cheapest: int = 999999
	for item in shops[category]["items"]:
		cheapest = min(cheapest, item["price"])
	return cheapest

func get_shop_items(category: String) -> Array:
	if shops.has(category):
		return shops[category]["items"]
	return []

func buy_item(category: String, item_name: String, price: int) -> bool:
	if not Currency.spend(price):
		return false

	var matched := false
	for entry in checklist:
		if entry["bought"]:
			continue
		if entry["type"] == "item" and entry["value"] == item_name:
			_fill_entry(entry, item_name, price)
			matched = true
			break

	if not matched:
		for entry in checklist:
			if entry["bought"]:
				continue
			if entry["type"] == "category" and entry["value"] == category:
				_fill_entry(entry, item_name, price)
				matched = true
				break

	checklist_updated.emit()
	return true

func _fill_entry(entry: Dictionary, item_name: String, price: int) -> void:
	entry["bought"] = true
	entry["item_name"] = item_name
	entry["price_paid"] = price

func checklist_complete_count() -> int:
	var count := 0
	for entry in checklist:
		if entry["bought"]:
			count += 1
	return count
