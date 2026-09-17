extends Area2D

@export var speed = 300
var angular_speed = PI
var screen_size
var hook_point = false
var hook_anchor
var hook_dist

var mouse_pos_global : Vector2
var rotation_pos_global : Vector2

var rotation_dist
var hook_dist_to_rotation

var is_orbiting : bool = false
var orbit_radius: float = 0.0
var current_angle: float = 0.0
var rotation_direction: float = 1.0
var peak_coord
var peak_dist

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hook_anchor = get_node("HookAnchor").position
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# When left click is pressed
	if Input.is_action_just_pressed("left_click"):
		# Mouse pos = A
		# hook anchor = B
		mouse_pos_global = get_global_mouse_position()
		var hook_anchor_global = to_global(get_node("HookAnchor").position)
		print("mouse pos : ", mouse_pos_global)
		print("hook pos : ", hook_anchor_global)
		
		# Vecteur directeur de l'hypothenuse
		#var dir_to_anchor = hook_anchor_global + mouse_pos_global
		var dir_to_anchor = mouse_pos_global - hook_anchor_global
		print("anchor direction : ", dir_to_anchor)
			
		var hypothenuse = dir_to_anchor.length()
		print("hypothenuse : ", hypothenuse)
	
		var angle = dir_to_anchor.angle_to(Vector2.UP)
	
		peak_dist = angle * hypothenuse
		print("peak dist : ", peak_dist)
	
		peak_coord = (peak_dist * Vector2.UP)
		#print("Vector UP : ", Vector2.UP)
		#print("peak coord : ", peak_coord)
		
	
		rotation_pos_global = Vector2(hook_anchor_global.x, mouse_pos_global.y)
	
		hook_point = true
		is_orbiting = false

	elif Input.is_action_just_released("left_click"):
		hook_point = false
		is_orbiting = false

	# Start orbiting
	if hook_point and not is_orbiting:
		if position.y <= rotation_pos_global.y:
			is_orbiting = true
			
			# Get the exact radius when reaching the blue line (Only viable for testing)
			orbit_radius = mouse_pos_global.distance_to(peak_coord)
			var to_car = global_position - mouse_pos_global
			current_angle = to_car.angle()
			
			# Determine the orientation of the rotation
			rotation_direction = 1.0 if mouse_pos_global.x > global_position.x else -1.0

	if is_orbiting:
		# Get the angular rotation speed
		var calc_angular_speed = speed / orbit_radius
		current_angle += calc_angular_speed * delta * rotation_direction
		
		global_position = mouse_pos_global + Vector2.RIGHT.rotated(current_angle) * orbit_radius
		
		if rotation_direction > 0:
			rotation = current_angle + PI
		else:
			rotation = current_angle
	else:
		var velocity = Vector2.UP.rotated(rotation) * speed
		#position += velocity * delta

	if hook_point:
		queue_redraw()

func _draw() -> void:
	if peak_coord:
		draw_line(hook_anchor, peak_coord, Color.GREEN, 2.0)
	
	if hook_point:
		var mouse_pos_local = to_local(mouse_pos_global)
		var rotation_pos_local = to_local(rotation_pos_global)
		
		var draw_radius = orbit_radius if is_orbiting else mouse_pos_global.distance_to(peak_coord)
		draw_arc(mouse_pos_local, draw_radius, 0, TAU, 32, Color.RED, 2.0)
		draw_line(mouse_pos_local, peak_coord, Color.BLUE, 2.0)
		
