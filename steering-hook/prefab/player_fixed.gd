extends Area2D

@export var speed : float = 300

var hook_anchor
var screen_size

var mouse_pos_global
var peak_coord
var peak_dist
var hook_anchor_global
var rot_direction
var velocity
var dir_to_anchor_local

var baseSpeed = speed
var isAlive = true

var score: int = 0
var endScene = preload("res://interface/you_dead_ui.tscn").instantiate()
var hook_trail

@export var BoosterValue = 1.2
@export var peak_distance_check_ahead : float = 10.0
@export var draw_visual : bool = false
@export var car_texture : Resource
@export var checkpoint_end : Node2D
@export var boost_go_start : Node2D = null
@export var boost_go_back : Node2D = null

var is_orbiting : bool = false
var has_input : bool = false
var tangente_added : bool = false
var behind : bool = false

var angle_tangente
var angle_tangente_local
var time_start
var time_end

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_start = Time.get_ticks_msec()
	hook_anchor = get_node("HookAnchor").position
	screen_size = get_viewport_rect().size
	
	var car_sprite = get_node("CarTexture")
	car_sprite.texture = car_texture
	
	hook_trail = get_node("Line2D")
	hook_trail.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time_now = Time.get_ticks_msec()
	time_end = time_now - time_start
	
	velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	
	hook_anchor_global = to_global(hook_anchor)
	
	if Input.is_action_just_pressed("left_click"):
		# Mouse pos = A
		# hook anchor = B
		mouse_pos_global = get_global_mouse_position()
		
		var dir_to_anchor = mouse_pos_global - hook_anchor_global
		
		dir_to_anchor_local = (to_local(mouse_pos_global) - to_local(hook_anchor_global))
		if dir_to_anchor_local.x == 0.0:
			dir_to_anchor_local.x += 0.01
			dir_to_anchor.x += 0.01
		
		var tangente = dir_to_anchor.rotated(PI / 2)
		var tangente_local = dir_to_anchor_local.rotated(PI / 2)
		
		angle_tangente = tangente.angle_to(Vector2.UP.rotated(rotation))
		angle_tangente_local = tangente_local.angle_to(Vector2.UP.rotated(rotation))
		
		var hypothenuse = dir_to_anchor.length()
		
		var angle = dir_to_anchor.angle_to(Vector2.UP.rotated(rotation))
		
		peak_dist = (cos(angle) * hypothenuse)
		
		if (dir_to_anchor_local.x <= 0):
			rot_direction = 1
		else:
			rot_direction = -1
		
		if (dir_to_anchor_local.y <= 0):
			behind = false
		else:
			behind = true
			
		peak_coord = (hook_anchor_global + (peak_dist * Vector2.UP.rotated(rotation)))
		
		has_input = true

	elif Input.is_action_just_released("left_click"):
		has_input = false
		peak_coord = null
		is_orbiting = false
		
		hook_trail.visible = false
	
	if has_input:
		if not behind:
			hook_trail.set_point_position(0, hook_anchor)
				
			hook_trail.visible = true
			hook_trail.set_point_position(1, to_local(mouse_pos_global))
			
			if ((hook_anchor_global.distance_to(peak_coord) <= peak_distance_check_ahead)):
				is_orbiting = true
		
			
	if is_orbiting:
		if not behind:
			var angular_speed = speed / mouse_pos_global.distance_to(peak_coord)
			rotation -= (angular_speed * delta) * rot_direction
	
	queue_redraw()	
	
func _draw() -> void:
	if draw_visual:
		if has_input:
			if not behind:
				var mouse_pos_local = to_local(mouse_pos_global)
				var peak_coord_local = to_local(peak_coord)
					
				#draw_arc(mouse_pos_local, mouse_pos_local.distance_to(peak_coord_local), 0, TAU, 32, Color.RED, 2.0)
				#draw_line(mouse_pos_local, hook_anchor, Color.GREEN, 2.0)
			#else:
			#	var mouse_pos_local = to_local(mouse_pos_global)
			#	var peak_coord_local = to_local(peak_coord)
					
			#	draw_arc(mouse_pos_local, mouse_pos_local.distance_to(peak_coord), 0, TAU, 32, Color.RED, 2.0)
				#draw_line(mouse_pos_local, hook_anchor, Color.GREEN, 2.0)


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
		16:
			print("FinishLine")
			finish()
		32:
			print("checkpoint")
			checkpoint()
			
	print("layer : ", layer)
	
	
		
			
func DeathExplode():
	print("died")
	speed = 0
	baseSpeed = 0
	endScene.hasWon = false
	endScene.score = score
	endScene.time = time_end / (float(1000))
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
	endScene.time = time_end / (float(1000))
	endScene.score = score
	endScene.hasWon = true
	get_tree().current_scene.add_child(endScene)
	speed = 0
	baseSpeed = 0
	
	
func checkpoint():
	print("checked the point")
	
	position = checkpoint_end.position
	rotation = checkpoint_end.rotation
	
	if boost_go_start:
		boost_go_start.visible
	
	


func _on_timer_timeout() -> void:
	print("end boost")
	speed = baseSpeed
	pass # Replace with function body.
