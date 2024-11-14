extends VSlider


func _ready() -> void:
	value = AudioPlayer.global_volume


func _process(delta: float) -> void:
	if value_changed:
		set_global_volume(value)
		AudioPlayer.global_volume = value

func set_global_volume(volume_percent: float) -> void:
	volume_percent = clamp(volume_percent, 0, 100)
	var db = lerp(-80, 0, volume_percent / 100.0)
	#print(db)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db)
