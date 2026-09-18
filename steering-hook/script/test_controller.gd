extends Area2D

@export var speed = 400
var isAlive = true
@export var BoosterValue = 1.2
var score = 0

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	speed = input_direction * speed

func _physics_process(delta):
	get_input()
	


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var layer: int = area.collision_layer
	print(layer)
	collide(layer, area)
	
	
func collide(layer:int , obj:Area2D)->void:
	match layer:
		1:
			print("wall")
		2:
			print("booster")
		3:
			print("obstacle")
		4:
			print("thy self")
		5:
			print("FinishLine")
		6:
			print("checkpoint")
			
func DeathExplode():
	print("died")
	
func Boosting():
	print("boosting")
	speed = speed*BoosterValue
	score = score+125
	
func finish():
	print("finished")
	
func checkpoint():
	print("checked the point")
	
