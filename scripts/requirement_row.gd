extends HBoxContainer

@onready var avatar: TextureRect = $AvatarTextureRect
@onready var name_label: Label = $TextBlock/NameLabel
@onready var message_label: Label = $TextBlock/MessageLabel

func setup(person_name: String, message: String, avatar_texture: Texture2D, bought: bool) -> void:
	name_label.text = person_name
	message_label.text = message
	if avatar_texture:
		avatar.texture = avatar_texture

	if bought:
		modulate = Color(1, 1, 1, 0.5)
	else:
		modulate = Color(1, 1, 1, 1)
