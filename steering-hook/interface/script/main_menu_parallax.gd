extends TextureRect

@export var parallax_val: float
@export var offs: Vector2 = Vector2(-164.0,56.0)

func _process(delta: float) -> void:
	offset_transform_position = get_global_mouse_position()/parallax_val + offs



func _on_button_button_down() -> void:
	GlobalsAudio.play_oneshot("car_honk")
	$TextureRect.show()


func _on_button_button_up() -> void:
	$TextureRect.hide()
