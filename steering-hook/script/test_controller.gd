extends Area2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	speed = input_direction * speed

func _physics_process(delta):
	get_input()
	


func _on_booster_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("do you like, my car")
	pass # Replace with function body.
