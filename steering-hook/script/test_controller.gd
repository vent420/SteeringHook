extends Area2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	speed = input_direction * speed

func _physics_process(delta):
	get_input()
	
	





func _on_body_entered(body) -> void:
	print("collided")
	pass # Replace with function body.
