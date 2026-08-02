extends Node

signal checklist_updated

var shops: Dictionary = {
	"toy": {
		"items": [
			{"name": "Trumpo", "price": 60, "texture": preload("res://assets/images/toys/trumpo.png")},
			{"name": "Pogs", "price": 50, "texture": preload("res://assets/images/toys/pogs.png")},
			{"name": "Yoyo", "price": 40, "texture": preload("res://assets/images/toys/yo-yo.png")},
			{"name": "Ball", "price": 120, "texture": preload("res://assets/images/toys/ball.png")},
			{"name": "Cooking Set", "price": 200, "texture": preload("res://assets/images/toys/cooking_set.png")},
			{"name": "Kite", "price": 90, "texture": preload("res://assets/images/toys/kite.png")},
			{"name": "Sungka", "price": 250, "texture": preload("res://assets/images/toys/sungka.png")},
			{"name": "Teddy Bear", "price": 300, "texture": preload("res://assets/images/toys/teddy_bear.png")},
		]
	},
	"souvenir": {
		"items": [
			{"name": "Keychain", "price": 55, "texture": preload("res://assets/images/souvenir/keychain.png")},
			{"name": "Dreamcatcher", "price": 180, "texture": preload("res://assets/images/souvenir/dreamcatcher.png")},
			{"name": "Abaniko", "price": 85, "texture": preload("res://assets/images/souvenir/abaniko.png")},
			{"name": "Bag", "price": 250, "texture": preload("res://assets/images/souvenir/bag.png")},
			{"name": "Jeepney Miniature", "price": 170, "texture": preload("res://assets/images/souvenir/jeepney_miniature.png")},
			{"name": "Salakot", "price": 185, "texture": preload("res://assets/images/souvenir/salakot.png")},
			{"name": "Tshirt", "price": 300, "texture": preload("res://assets/images/souvenir/tshirt.png")},
		]
	},
	"food": {
		"items": [
			{"name": "Polvoron",  "price": 30, "texture": preload("res://assets/images/food/polvoron.png")},
			{"name": "Chicharon",  "price": 50, "texture": preload("res://assets/images/food/chicharon.png")},
			{"name": "Dried Mangoes", "price": 120, "texture": preload("res://assets/images/food/dried mango.png")},
			{"name": "Mani", "price": 25, "texture": preload("res://assets/images/food/mani.png")},
			{"name": "Suman", "price": 35, "texture": preload("res://assets/images/food/suman.png")},
			{"name": "Biscocho", "price": 40, "texture": preload("res://assets/images/food/biscocho.png")},
			{"name": "Banana Chips", "price": 60, "texture": preload("res://assets/images/food/banana_chips.png")},
			{"name": "Bibingka", "price": 50, "texture": preload("res://assets/images/food/bibingka.png")},
			{"name": "Buko Pie", "price": 180, "texture": preload("res://assets/images/food/buko_pie.png")},
			{"name": "Pastillas", "price": 65, "texture": preload("res://assets/images/food/pastillas.png")},
			{"name": "Puto", "price": 55, "texture": preload("res://assets/images/food/puto.png")},
		]
	},
}

var people_pool: Array = [
	{"name": "Tita Baby", "avatar": preload("res://assets/images/pfp/ate_pfp.png")},
	{"name": "Sharmaine", "avatar": preload("res://assets/images/pfp/sharmaine_pfp.png")},
	{"name": "Girlie", "avatar": preload("res://assets/images/pfp/girlie_pfp.png")},
	{"name": "Panying", "avatar": preload("res://assets/images/pfp/panying_pfp.png")},
	{"name": "Ate Grace", "avatar": preload("res://assets/images/pfp/ate_pfp.png")},
	{"name": "Tita Princess", "avatar": preload("res://assets/images/pfp/tita_princess_pfp.png")},
	{"name": "Tito Boy", "avatar": preload("res://assets/images/pfp/tito_boy_pfp.png")},
	{"name": "AAA Mama Globe", "avatar": preload("res://assets/images/pfp/mama_globe_pfp.png")},
	{"name": "Papa", "avatar": preload("res://assets/images/pfp/papa_pfp.png")},
	{"name": "Kuya Kim", "avatar": preload("res://assets/images/pfp/kuya_pfp.png")},
	{"name": "Bunso", "avatar": preload("res://assets/images/pfp/bunso_pfp.png")},
]

var requirement_types_pool: Array = [
	{"type": "category", "value": "toy"},
	{"type": "category", "value": "souvenir"},
	{"type": "category", "value": "food"},
	#food
	{"type": "item", "value": "Polvoron"},
	{"type": "item", "value": "Chicharon"},
	{"type": "item", "value": "Dried Mangoes"},
	{"type": "item", "value": "Mani"},
	{"type": "item", "value": "Suman"},
	{"type": "item", "value": "Biscocho"},
	{"type": "item", "value": "Banana Chips"},
	{"type": "item", "value": "Bibingka"},
	{"type": "item", "value": "Buko Pie"},
	{"type": "item", "value": "Pastillas"},
	{"type": "item", "value": "Puto"},
	#toy
	{"type": "item", "value": "Trumpo"},
	{"type": "item", "value": "Yoyo"},
	{"type": "item", "value": "Pogs"},
	{"type": "item", "value": "Ball"},
	{"type": "item", "value": "Cooking Set"},
	{"type": "item", "value": "Kite"},
	{"type": "item", "value": "Sungka"},
	{"type": "item", "value": "Teddy Bear"},
	#souvenir
	{"type": "item", "value": "Abaniko"},
	{"type": "item", "value": "Bag"},
	{"type": "item", "value": "Dreamcatcher"},
	{"type": "item", "value": "Jeepney Miniature"},
	{"type": "item", "value": "Keychain"},
	{"type": "item", "value": "Salakot"},
	{"type": "item", "value": "Tshirt"}

]

var category_message_templates: Array = [
	"Pwede paki bilhan ako ng {value}?",
	"Wag kalimutan yung {value} ha!",
	"Gusto ko sana ng {value} pasalubong.",
	"{value} lang, kahit ano basta {value}.",
	"I forgot to tell you to buy {value}.",
	"Beh, sabi ni mama bilhan mo raw siya ng {value}.",
	"Ang cra is ving for to is day's vid is yew is {value}.",
	"Pabili ako teh ng {value}, showcase ko lang sa vlog sa tiktok.",
	"{value} na kahit ano, sa Lunes bayad",
	"Uych, sisch, pabilich ngch {value}ch hach? Salamatch.",
	"Good morning. Pabili ako ng {value}. Salamat.",
	"b3bang…., {value} lang ak1n. tNx… mwa.",
	"yohoo, sa {value} ang tingin! yan lang akin, lamats.",
	"{value} akin ah? ket ano lng,, slr walang signal sa bukid.",
	"pabili nga {value}, kailangan ni bunso para sa project nya",
]
var item_message_templates: Array = [
	"Yung {value} lang talaga gusto ko!",
	"Wag kang uuwi kung wala kang {value}!",
	"Sabi ko sayo, {value} lang ha!",
	"Beh, sabi ni mama bilhan mo raw siya ng {value}.",
	"Uych, sisch, pabilich ngch {value}ch hach? Salamatch.",
	"Reto kita sa crush mo teh, bilhin mo lang ako ng {value}",
	"{value} akin ah? slr walang signal sa bukid.",
	"pabili nga {value}, kailangan ni bunso para sa project nya",
	"{value} lang akin, sa Lunes bayad.",
	"Hi'ed. Ang'ed aking'ed kasautan'ed ay'ed... {value}'ed po'ed ate'ed.",
]

var checklist: Array = []
var extra_purchase_prices: Array = []

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
	extra_purchase_prices.clear()

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

	if not matched:
		extra_purchase_prices.append(price)

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

func calculate_score(minutes_left: int = 0) -> int:
	var completed := checklist_complete_count()
	var completion_score := completed * 100

	var generosity_bonus := 0
	if completed > 0:
		var total_paid := 0
		for entry in checklist:
			if entry["bought"]:
				total_paid += entry["price_paid"]
		generosity_bonus = int(total_paid / float(completed))

	var extra_bonus := 0
	if not extra_purchase_prices.is_empty():
		var total_extra := 0
		for price in extra_purchase_prices:
			total_extra += price
		extra_bonus = int(total_extra / float(extra_purchase_prices.size()))

	var speed_bonus := minutes_left * 5

	return completion_score + generosity_bonus + extra_bonus + speed_bonus
