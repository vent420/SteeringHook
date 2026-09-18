extends Control


func _on_button_2_button_down() -> void:
	var array: Array[String] = [
		"res://audio/sfx_boost_effect_v01.ogg",
		"res://audio/sfx_car_engine_startup_v01.ogg",
		"res://audio/sfx_hook_attach_v01.ogg",
		"res://audio/sfx_hook_detach_v01.ogg",
		"res://audio/sfx_hook_retract_v01.ogg",
		"res://audio/sfx_hook_trow_v01.ogg",
		"res://audio/sfx_car_finish_win_v01.ogg",
		"res://audio/sfx_car_crash_lose_v01.ogg"
	]
	GlobalsAudio.play_oneshot(array.pick_random(),1.0,1.0,true)

func _on_button_button_down() -> void:
	GlobalsAudio.start_level()

func _on_button_3_button_down() -> void:
	GlobalsAudio.music_end()
	GlobalsAudio.engine_loop_end()

func _on_check_button_toggled(toggled_on: bool) -> void:
	GlobalsAudio.change_drifting(toggled_on)


func _on_h_slider_value_changed(value: float) -> void:
	GlobalsAudio.engine_change(value,100.0)


func _on_h_slider_2_value_changed(value: float) -> void:
	GlobalsAudio.engine_vol_mult = value
func _on_h_slider_3_value_changed(value: float) -> void:
	GlobalsAudio.g_sounds_volume = value
func _on_h_slider_4_value_changed(value: float) -> void:
	GlobalsAudio.change_music_volume( value )
