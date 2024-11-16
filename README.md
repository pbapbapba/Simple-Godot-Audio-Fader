# Simple Godot Audio Fader

## About
A simple Godot 4 project to demonstrate audio **fade in**, **fade out**, and **crossfade**.

The projects uses Godot's powerful **Tween** system instead of the **AnimationPlayer**.

Ideal for beginners and game jams.

## How It Works
1. Fade In
    + A single **Tween** setting the *volume_db* property of an **AudioStreamPlayer** to *0dB* volume over a period of given time.
2. Fade Out
    + A single **Tween** setting the *volume_db* property of an **AudioStreamPlayer** to *-80dB* volume over a period of given time.
3. Crossfade
    + Using parallel **Tweens**, it is possible to simultaneously set the *volume_db* property of 2 **AudioStreamPlayers**. With the first audio being turned down to *-80db* and the other turned up to *0dB* volume.

## Usage
```PHP
fade_in(audio_to_fade: AudioStreamPlayer, fade_duration: float = 3.0)
```

Select an audio source to fade in and its duration.

---

```PHP
fade_out(audio_to_fade: AudioStreamPlayer, fade_duration: float = 3.0, auto_stop: bool = true)
```

Select an audio source to fade out and its duration. With optional auto stop when -80 dB volume is reached.

---

```PHP
crossfade(fade_out_audio: AudioStreamPlayer, fade_in_audio: AudioStreamPlayer, crossfade_duration: float = 3.0)
```    

Select two audio sources to crossfade and its duration.

## Credits
Audio loops created by [pbapbapba](https://github.com/pbapbapba/) under [Creative Commons CC0 1.0 License](https://creativecommons.org/public-domain/cc0/).
