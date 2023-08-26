extends CharacterBody2D

# constants

const SPEED = 50.0

# enums

@onready var current_direction = Vector2.DOWN

# vars

var current_target = null

func _process(_delta):
	handle_input()

func _physics_process(_delta):
	move_and_slide()
	handle_selection()

func handle_input():
	var x_input = 0.0
	if Input.is_action_pressed("p1_left"):
		x_input += -1
		current_direction = Vector2.LEFT
	if Input.is_action_pressed("p1_right"):
		x_input += 1
		current_direction = Vector2.RIGHT

	var y_input = 0.0
	if Input.is_action_pressed("p1_up"):
		y_input += -1
		current_direction = Vector2.UP
	if Input.is_action_pressed("p1_down"):
		y_input += 1
		current_direction = Vector2.DOWN
	
	velocity = Vector2(x_input, y_input) * SPEED
	
	if Input.is_action_just_pressed("p1_use") and current_target != null:
		current_target.interacting = not current_target.interacting
	
func handle_selection():
	var space_state = get_world_2d().direct_space_state
	
	var target_position = position + current_direction * 64
	
	var query = PhysicsRayQueryParameters2D.create(position, target_position, 2, [])
	
	var hit = space_state.intersect_ray(query)
	
	if hit:
		
		if hit.collider != current_target and current_target != null:
			current_target.selected = false
		
		if hit.collider.is_in_group("player_selectable"):
			current_target = hit.collider
			current_target.selected = true
		
	elif current_target != null:
		current_target.selected = false
		current_target = null
