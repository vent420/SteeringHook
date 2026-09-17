extends Area2D

@export var speed = 300

var hook_anchor
var screen_size

var mouse_pos_global
var peak_coord
var peak_dist
var hook_anchor_global
var rot_direction

var is_orbiting : bool = false
var has_input : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hook_anchor = get_node("HookAnchor").position
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	
	if Input.is_action_just_pressed("left_click"):
		# Mouse pos = A
		# hook anchor = B
		mouse_pos_global = get_global_mouse_position()
		hook_anchor_global = to_global(get_node("HookAnchor").position)
		#print("mouse pos : ", mouse_pos_global)
		#print("hook pos : ", hook_anchor_global)
		
		# Vecteur directeur de l'hypothenuse
		var dir_to_anchor = mouse_pos_global - hook_anchor_global
		#print("anchor direction : ", dir_to_anchor)
			
		var hypothenuse = dir_to_anchor.length()
		#print("hypothenuse : ", hypothenuse)
	
		var angle = dir_to_anchor.angle_to(Vector2.UP.rotated(rotation))
	
		peak_dist = cos(angle) * hypothenuse
		#print("peak dist : ", peak_dist)
	
		if (mouse_pos_global.x < hook_anchor_global.x):
			rot_direction = 1
		else:
			rot_direction = -1
			
		peak_coord = hook_anchor_global + (peak_dist * Vector2.UP.rotated(rotation))
		
		#print("peak coord : ", peak_coord)
		
		has_input = true

	elif Input.is_action_just_released("left_click"):
		has_input = false
		peak_coord = null
		is_orbiting = false
	
	if has_input:
		print("position : ", position)
		print("peak : ", peak_coord)
		if position <= peak_coord:
			is_orbiting = true
			
	if is_orbiting:
		#print(mouse_pos_global.distance_to(peak_coord))
		var angular_speed = speed / mouse_pos_global.distance_to(peak_coord)
		rotation -= (angular_speed * delta) * rot_direction
	
	queue_redraw()	
	
func _draw() -> void:
	#if peak_coord:
		#draw_line(debugInfo, debugInfoB, Color.GREEN, 2.0)
	if has_input:
		var mouse_pos_local = to_local(mouse_pos_global)
			
		draw_arc(mouse_pos_local, mouse_pos_global.distance_to(peak_coord), 0, TAU, 32, Color.RED, 2.0)
