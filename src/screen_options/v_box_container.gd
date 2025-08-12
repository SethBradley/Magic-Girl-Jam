extends VBoxContainer

var bus_index: int

# audio functions
# music and sfx play through their own audio buses
# the sliders set the bus volume directly
# the sliders set Settings.variable as well (but this setting isn't used) 

# music volume
func _on_slider_music_value_changed(value: float) -> void:
	bus_index = AudioServer.get_bus_index("music")
	Settings.mus_vol = value
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value)) # make this a set_audio_vol() function?
	pass # Replace with function body.

# sfx volume
func _on_slider_sfx_value_changed(value: float) -> void:
	bus_index = AudioServer.get_bus_index("sfx")
	Settings.mus_vol = value
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value)) # make this a set_sfx_vol() function?
	pass # Replace with function body.
