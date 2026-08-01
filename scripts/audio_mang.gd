extends Node

# Initialize audio channels to global audio
var sfx_stream: AudioStreamPlayer
var bgm_stream: AudioStreamPlayer

@export_group("main")
@export var clips: Node

func play_bgm(audio_name: String,from_position: float = 0.0) -> void:
		bgm_stream = clips.get_node(audio_name)
		bgm_stream.set_volume_db(-5.0)
		bgm_stream.play(from_position) 

func play_sfx(audio_name: String,from_position: float = 0.0) -> void:
		sfx_stream = clips.get_node(audio_name)
		sfx_stream.set_volume_db(-3.0)
		sfx_stream.play(from_position)
		
# At scene exit
func _exit_tree() -> void:
	if sfx_stream != null and bgm_stream != null:
		sfx_stream.stop()
		bgm_stream.stop()
		
	
		
