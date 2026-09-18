extends TextureRect

@export var prlx: float = 90
@export var off: Vector2 = Vector2(-160,50)

func _process(delta: float) -> void:
	offset_transform_position = get_global_mouse_position()/prlx + off



func _on_button_button_down() -> void:
	$"../TextureRect/TextureRect".show()
	GlobalsAudio.play_oneshot("car_honk")


func _on_button_button_up() -> void:
	$"../TextureRect/TextureRect".hide()
