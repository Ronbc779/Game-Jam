extends Node

var bgm_stream: AudioStreamPlayer

@export_group("main")
@export var clips: Node

func play(audio_name: String,from_position: float = 0.0) -> void:
		bgm_stream = clips.get_node(audio_name)
		bgm_stream.set_volume_db(-5.0)
		bgm_stream.play(from_position) 
