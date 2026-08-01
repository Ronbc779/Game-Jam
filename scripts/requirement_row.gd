extends HBoxContainer

@onready var avatar: TextureRect = $AvatarTextureRect
@onready var text_block: VBoxContainer = $TextBlock
@onready var name_label: Label = $TextBlock/NameLabel
@onready var message_label: Label = $TextBlock/MessageLabel

func setup(person_name: String, message: String, avatar_texture: Texture2D, bought: bool) -> void:
	size_flags_horizontal = Control.SIZE_EXPAND_FILL

	avatar.custom_minimum_size = Vector2(48, 48)
	avatar.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN

	text_block.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_block.custom_minimum_size = Vector2(180, 0)

	name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	message_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	name_label.text = person_name
	message_label.text = message
	if avatar_texture:
		avatar.texture = avatar_texture

	modulate = Color(1, 1, 1, 0.5) if bought else Color(1, 1, 1, 1)
