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
var dir_to_anchor_local

@export var peak_distance_check_ahead : float = 10.0
@export var peak_distance_check_behind : float = 75.0
@export var draw_visual : bool = false

var is_orbiting : bool = false
var has_input : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hook_anchor = get_node("HookAnchor").position
	screen_size = get_viewport_rect().size
	
	var car_sprite = get_node("CarTexture")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	
	hook_anchor_global = to_global(hook_anchor)
	
	if Input.is_action_just_pressed("left_click"):
		# Mouse pos = A
		# hook anchor = B
		mouse_pos_global = get_global_mouse_position()
		
		var dir_to_anchor = mouse_pos_global - hook_anchor_global
		
		dir_to_anchor_local = (to_local(mouse_pos_global) - to_local(hook_anchor_global))
		
		var hypothenuse = dir_to_anchor.length()
		
		var angle = dir_to_anchor.angle_to(Vector2.UP.rotated(rotation))
		
		peak_dist = (cos(angle) * hypothenuse)
		
		if (dir_to_anchor_local.x <= 0):
			rot_direction = 1
		else:
			rot_direction = -1
			
		peak_coord = (hook_anchor_global + (peak_dist * Vector2.UP.rotated(rotation)))
		
		has_input = true

	elif Input.is_action_just_released("left_click"):
		has_input = false
		peak_coord = null
		is_orbiting = false
	
	if has_input:
		print("dir to anchor : ", dir_to_anchor_local)
		if (dir_to_anchor_local.y <= 0):
			if ((hook_anchor_global.distance_to(peak_coord) <= peak_distance_check_ahead)):
				is_orbiting = true
		else:
			if ((hook_anchor_global.distance_to(peak_coord) <= peak_distance_check_behind)):
				is_orbiting = true
			
	if is_orbiting:
		var angular_speed = speed / mouse_pos_global.distance_to(peak_coord)
		rotation -= (angular_speed * delta) * rot_direction
	
	queue_redraw()	
	
func _draw() -> void:
	if draw_visual:
		if has_input:
			var mouse_pos_local = to_local(mouse_pos_global)
			var peak_coord_local = to_local(peak_coord)
				
			draw_arc(mouse_pos_local, mouse_pos_local.distance_to(peak_coord_local), 0, TAU, 32, Color.RED, 2.0)
			#draw_line(mouse_pos_local, peak_coord_local, Color.GREEN, 2.0)
