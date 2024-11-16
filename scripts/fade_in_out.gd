extends Node

@export var audio_stream_player: AudioStreamPlayer
@onready var tween: Tween

func fade_in(audio_to_fade: AudioStreamPlayer, fade_duration: float = 3.0) -> void:
	if audio_to_fade.playing == false:
		audio_to_fade.play()
	if tween:
		tween.kill()
	print("\n------------------\nStarting fade in.\nCurrent volume: ", audio_to_fade.volume_db, "dB\nAudio is playing: ", audio_to_fade.playing)
	tween = create_tween()
	tween.connect("finished", _on_tween_finished)
	tween.tween_property(audio_to_fade, "volume_db", 0, fade_duration).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT) #Transition and easing set for faster fade in.

func fade_out(audio_to_fade: AudioStreamPlayer, fade_duration: float = 3.0, auto_stop: bool = true) -> void:
	if tween:
		tween.kill()
	print("\n------------------\nStarting fade out.\nCurrent volume: ", audio_to_fade.volume_db, "dB\nAudio is playing: ", audio_to_fade.playing)
	tween = create_tween()
	tween.connect("finished", _on_tween_finished)
	tween.tween_property(audio_to_fade, "volume_db", -80, fade_duration) #Turn down the volume to -80dB.
	#Optional, as it might no be ideal to stop the audio in some use cases.
	if auto_stop:
		tween.tween_property(audio_to_fade, "playing", false, 0.0)

func _on_tween_finished() -> void:
	print("\nFading finished.\nCurrent volume: ", audio_stream_player.volume_db, "dB\nAudio is playing: ", audio_stream_player.playing)
	#Or implement own code upon fade completion...

func _on_fade_in_pressed() -> void:
	#Start a fade in with a default duration of 3.0 seconds.
	fade_in(audio_stream_player)

func _on_fade_out_pressed() -> void:
	#Start a 4.0 second fade out with default auto stop.
	fade_out(audio_stream_player, 4.0)

func _on_crossfade_scene_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/crossfade_scene.tscn")
