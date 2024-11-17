extends AudioStreamPlayer


const cipher2 = preload("res://Assets/Audio/Music/Cipher2.mp3")
const presenterator = preload("res://Assets/Audio/Music/Presenterator.mp3")
var global_volume = 100


func _play_music(music: AudioStream, volume = 0.0,):
	if stream == music:
		print("Same music")
		return
	
	stream = music
	volume_db = volume
	play()

func play_music(music_name):
	if music_name == "cipher2":
		_play_music(cipher2)
	elif music_name == "presenterator":
		_play_music(presenterator)
