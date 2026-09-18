extends Area2D

@export var speed = 300

var hook_anchor
var screen_size

var mouse_pos_global
var peak_coord
var peak_dist
var hook_anchor_global
var rot_direction
var velocity

var debug_direction

var is_orbiting : bool = false
var has_input : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hook_anchor = get_node("HookAnchor").position
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	
	debug_direction = Vector2.UP.rotated(rotation)
	
	hook_anchor_global = to_global(get_node("HookAnchor").position)
	
	print("Hook anchor global : ", hook_anchor_global)
	print("Hook anchor local : ", get_node("HookAnchor").position)
	
	if Input.is_action_just_pressed("left_click"):
		# Mouse pos = A
		# hook anchor = B
		mouse_pos_global = get_global_mouse_position()
		
		var dir_to_anchor = mouse_pos_global - hook_anchor_global
			
		var hypothenuse = dir_to_anchor.length()
		
		var angle = dir_to_anchor.angle_to(Vector2.UP.rotated(rotation))
	
		peak_dist = cos(angle) * hypothenuse
		
		if (velocity.y <= 0):
			if (mouse_pos_global.x < hook_anchor_global.x):
				rot_direction = 1
			else:
				rot_direction = -1
		
		else:
			if (mouse_pos_global.x < hook_anchor_global.x):
				rot_direction = -1
			else:
				rot_direction = 1
			
		peak_coord = hook_anchor_global + (peak_dist * Vector2.UP.rotated(rotation))
		
		has_input = true

	elif Input.is_action_just_released("left_click"):
		has_input = false
		peak_coord = null
		is_orbiting = false
	
	if has_input:
		if ((hook_anchor_global.distance_to(peak_coord) <= -1) or (hook_anchor_global.distance_to(peak_coord) <= 1)):
			is_orbiting = true
			
	if is_orbiting:
		var angular_speed = speed / mouse_pos_global.distance_to(peak_coord)
		rotation -= (angular_speed * delta) * rot_direction
	
	queue_redraw()	
	
func _draw() -> void:
	if has_input:
		var mouse_pos_local = to_local(mouse_pos_global)
		var peak_coord_local = to_local(peak_coord)
			
		draw_arc(mouse_pos_local, mouse_pos_global.distance_to(peak_coord), 0, TAU, 32, Color.RED, 2.0)
		draw_line(mouse_pos_local, peak_coord_local, Color.GREEN, 2.0)
