extends HBoxContainer

@onready var texture_rect: TextureRect = $TextureRect
@onready var name_label: Label = $NameLabel
@onready var minus_button: Button = $MinusButton
@onready var quantity_label: Label = $QuantityLabel
@onready var plus_button: Button = $PlusButton
@onready var buy_button: Button = $BuyButton

var item_name: String = ""
var price: int = 0
var quantity: int = 1
var max_quantity: int = 10

func setup(new_name: String, new_price: int, texture: Texture2D) -> void:
	item_name = new_name
	price = new_price
	name_label.text = new_name
	texture_rect.texture = texture
	quantity = 1
	update_labels()

func _ready() -> void:
	buy_button.text = "Buy ₱%d" % (price * quantity)
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
	var total_price := price * quantity
	if Currency.spend(total_price):
		print("Bought %d x %s for ₱%d" % [quantity, item_name, total_price])
		quantity = 1
		update_labels()
	else:
		print("Not enough money for %d x %s" % [quantity, item_name])
