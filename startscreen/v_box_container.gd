extends VBoxContainer

@onready var fade_timer: Timer = $"FadeTimer"

#main code

var is_fading = false

#use _process to get input
func _process(delta):	
	if is_fading == true:
		fade()
	else:
		fade_timer.start()
		is_fading = true
func fade():
	modulate.a = inverse_lerp(fade_timer.wait_time, 0, fade_timer.time_left)

func _on_fade_timer_timeout():
	is_fading = false
