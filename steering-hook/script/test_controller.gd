extends Area2D

@export var speed = 400
var baseSpeed = speed
var isAlive = true
@export var BoosterValue = 1.2
var score = 0
var endScene = preload("res://interface/you_dead_ui.tscn").instantiate()

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
			DeathExplode()
		2:
			print("booster")
			Boosting()
		3:
			print("obstacle")
			DeathExplode()
		4:
			print("thy self")
		5:
			print("FinishLine")
			finish()
		6:
			print("checkpoint")
			checkpoint()
			
func DeathExplode():
	print("died")
	endScene.score = score
	endScene.hasWon = false
	get_tree().current_scene.add_child(endScene)
	
	#open end
	
func Boosting():
	print("boosting")
	speed = speed*BoosterValue
	score = score+125
	$Timer.wait_time = 2
	$Timer.start()
	
func finish():
	print("finished")
	endScene.score = score
	endScene.hasWon = true
	get_tree().current_scene.add_child(endScene)
	
	
func checkpoint():
	print("checked the point")
	


func _on_timer_timeout() -> void:
	print("end boost")
	speed = baseSpeed
	pass # Replace with function body.
