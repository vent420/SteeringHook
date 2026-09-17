extends MarginContainer


func _on_play_b_pressed() -> void:
	get_tree().change_scene_to_file("res://interface/level_selection.tscn")
	print("pressed play")
	pass


func _on_quit_b_pressed() -> void:	
	get_tree().quit()
	pass
