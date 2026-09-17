extends MarginContainer


func _on_return_b_pressed() -> void:
	get_tree().change_scene_to_file("res://interface/main.tscn")
	print("pressed return")
	pass # Replace with function body.

func _on_play_l_1_pressed() -> void:
	get_tree().change_scene_to_file("res://interface/main.tscn") #level 1 file path
	pass # Replace with function body.

func _on_play_l_2_pressed() -> void:
	get_tree().change_scene_to_file("res://interface/main.tscn") #level 2 file path
	pass # Replace with function body.

func _on_play_l_3_pressed() -> void:
	get_tree().change_scene_to_file("res://interface/main.tscn") #level 3 file path
	pass # Replace with function body.

func _on_play_l_4_pressed() -> void:
	get_tree().change_scene_to_file("res://interface/main.tscn") #level 4 file path
	pass # Replace with function body.
