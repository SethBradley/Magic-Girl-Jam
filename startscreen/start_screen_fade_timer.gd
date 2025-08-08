extends Timer
@onready var fade_timer: Timer = $"."

#main code

var is_fading = true

#use _process to get input
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		fade_timer.start()
		is_fading = true
	
	if is_fading == true:
		fade()
		
func fade():
	inverse_lerp(0, fade_timer.wait_time, fade_timer.time_left)

func _on_fade_timer_timeout():
	is_fading = false
