extends CanvasLayer

# Signal for global events to happen during black screen
signal on_transition_finished

# Init references
@onready var color_rect = $ColorRect
@onready var animation = $AnimationPlayer

func _ready():
	color_rect.visible = false
	# Connects boolean to global signal
	animation.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name: String):
	if anim_name == "to_black":
		# Emit global signal
		on_transition_finished.emit()
		animation.play("to_scene")
	elif anim_name == "to_scene":
		color_rect.visible = false
	
func transition(): # Transition start
	color_rect.visible = true
	animation.play("to_black")
	
