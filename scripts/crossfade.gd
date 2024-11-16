extends Node

#Audio source handling is easily customizable and could be replaced with @onready variables as well.
@export var audio_1: AudioStreamPlayer
@export var audio_2: AudioStreamPlayer

@onready var tween: Tween
@onready var currently_fading: bool = false

func crossfade(fade_out_audio: AudioStreamPlayer, fade_in_audio: AudioStreamPlayer, crossfade_duration: float = 3.0) -> void:
	if currently_fading == false:
		currently_fading = true
		print("\n------------------\nStarting crossfade.\nCurrent volume of Audio 1: ", fade_out_audio.volume_db, "dB\nCurrent volume of Audio 2: ", fade_in_audio.volume_db, "dB")
		#Start playing audio 2. Might not be needed in every use case.
		fade_in_audio.play()
		if tween:
			tween.kill()
		#set_parallel for parallel fade in and out of 2 audio nodes.
		tween = create_tween().set_parallel(true)
		tween.connect("finished", _on_tween_finished)
		tween.tween_property(fade_out_audio,"volume_db", -80, crossfade_duration) #Turn down audio 1 to -80dB.
		tween.tween_property(fade_in_audio,"volume_db", 0, crossfade_duration).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT) #Transition and easing set for faster fade in.
		#Stop the first audio after the fading is finished. By chaining the tween, it waits till the previous 2 tweens are finished.
		tween.chain().tween_property(fade_out_audio, "playing", false, 0.0)

func _on_tween_finished() -> void:
	currently_fading = false
	print("\nCrossfade finished.\nCurrently fading: ", currently_fading, "\nCurrent volume of Audio 1: ",audio_1.volume_db, "dB\nAudio 1 is playing: ", audio_1.playing, "\nCurrent volume of Audio 2: ", audio_2.volume_db, "dB\nAudio 2 is playing: ", audio_2.playing)
	#Or implement own code upon crossfade completion...

func _on_fade_1_to_2_pressed() -> void:
	#Start a 3 second long crossfade from audio 1 to audio 2.
	crossfade(audio_1, audio_2, 3.0)

func _on_fade_2_to_1_pressed() -> void:
	#Start a 3 second long crossfade from audio 2 to audio 1.
	crossfade(audio_2, audio_1, 3.0)

func _on_fade_scene_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/fade_in_out_scene.tscn")
