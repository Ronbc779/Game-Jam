extends AnimationPlayer

func _ready() -> void:
	await TransitionScreen.on_transition_finished
	play("slide_up")
