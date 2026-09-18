extends Control

func _on_quit_b_pressed() -> void:	
	get_tree().quit()

func _on_texture_button_button_down() -> void:
	GlobalsAudio.play_oneshot("ui_click")
	get_tree().change_scene_to_file("res://interface/level_selection.tscn")


func _on_texture_button_mouse_entered() -> void:
	GlobalsAudio.play_oneshot("ui_hover",0.5)
