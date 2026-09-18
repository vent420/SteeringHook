extends TextureButton

@export var level_path: String


func _on_mouse_entered() -> void:
	GlobalsAudio.play_oneshot("ui_hover")


func _on_button_down() -> void:
	get_tree().change_scene_to_file(level_path)
