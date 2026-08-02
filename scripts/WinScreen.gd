extends Control

@onready var result_label: Label = $ResultLabel
@onready var play_again_button: Button = $PlayAgainButton

func _ready() -> void:
	AudioMang.stop_bgm()
	AudioMang.play_sfx("winSFX")
	result_label.text = "You made it home with all your pasalubong!\nScore: %d" % GameResult.final_score
	play_again_button.pressed.connect(_on_play_again_pressed)

func _on_play_again_pressed() -> void:
	GameResult.restart()
