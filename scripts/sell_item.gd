extends HBoxContainer

@onready var texture_rect: TextureRect = $TextureRect
@onready var name_label: Label = $NameLabel
@onready var minus_button: Button = $MinusButton
@onready var quantity_label: Label = $QuantityLabel
@onready var plus_button: Button = $PlusButton
@onready var buy_button: Button = $BuyButton

var item_name: String = ""
var price: int = 0
var category: String = ""
var quantity: int = 1
var max_quantity: int = 10

func setup(new_name: String, new_price: int, new_category: String, texture: Texture2D = null) -> void:
	item_name = new_name
	price = new_price
	category = new_category
	name_label.text = new_name
	if texture:
		texture_rect.texture = texture
	quantity = 1
	update_labels()

func _ready() -> void:
	minus_button.pressed.connect(_on_minus_pressed)
	plus_button.pressed.connect(_on_plus_pressed)
	buy_button.pressed.connect(_on_buy_pressed)

func _on_minus_pressed() -> void:
	quantity = max(1, quantity - 1)
	update_labels()

func _on_plus_pressed() -> void:
	quantity = min(max_quantity, quantity + 1)
	update_labels()

func update_labels() -> void:
	quantity_label.text = str(quantity)
	buy_button.text = "Buy ₱%d" % (price * quantity)

func _on_buy_pressed() -> void:
	var bought_count := 0
	for i in quantity:
		if ShopManager.buy_item(category, item_name, price):
			bought_count += 1
		else:
			break

	if bought_count > 0:
		print("Bought %d x %s for ₱%d" % [bought_count, item_name, price * bought_count])
	if bought_count < quantity:
		print("Could only afford %d of %d" % [bought_count, quantity])

	quantity = 1
	update_labels()
