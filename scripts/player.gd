extends CharacterBody2D

# constants

const SPEED = 100.0
const ACC = 120.0

# enums

@onready var current_direction = Vector2.DOWN

# vars

@onready var sprite = $Sprite2D
@onready var animator = $AnimationPlayer
@onready var selector = $Selector
var current_target = null
var acceleration: Vector2 = Vector2(0, 0)
var decceleration: Vector2 = Vector2(0, 0)


func _process(delta):
	handle_input(delta)

func _physics_process(delta):
	
	velocity += acceleration * delta
	if acceleration.x != 0.0 and acceleration.y != 0.0:
		velocity.x = clamp(velocity.x, -SPEED * 0.7, SPEED * 0.7)
		velocity.y = clamp(velocity.y, -SPEED * 0.7, SPEED * 0.7)
	else:
		velocity.x = clamp(velocity.x, -SPEED, SPEED)
		velocity.y = clamp(velocity.y, -SPEED, SPEED)
		
	velocity += decceleration * delta
	
	if decceleration.x < 0:
		velocity.x = clamp(velocity.x, 0.0, SPEED)
	elif decceleration.x > 0:
		velocity.x = clamp(velocity.x, -SPEED, 0.0)
		
	if decceleration.y < 0:
		velocity.y = clamp(velocity.y, 0.0, SPEED)
	elif decceleration.y > 0:
		velocity.y = clamp(velocity.y, -SPEED, 0.0)
	
	animator.speed_scale = clamp(velocity.length(), 0.7, SPEED) / SPEED
	
	move_and_slide()
	handle_selection()

func handle_input(delta):
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
	
	if velocity.x == 0 and velocity.y == 0:
		match current_direction:
			Vector2.DOWN:
				animator.play("player_idle_down")
			Vector2.UP:
				animator.play("player_idle_up")
			_:
				animator.play("player_idle_side")
				sprite.flip_h = (current_direction == Vector2.LEFT)
				if sprite.flip_h:
					selector.rotation = -90
				else:
					selector.rotation = 90
	else:
		match current_direction:
			Vector2.DOWN:
				animator.play("player_walk_down")
			Vector2.UP:
				animator.play("player_walk_up")
			_:
				animator.play("player_walk_side")
				sprite.flip_h = (current_direction == Vector2.LEFT)
				if sprite.flip_h:
					selector.rotation = -90
				else:
					selector.rotation = 90
				
	if x_input != 0.0 and y_input != 0.0:
		x_input *= 0.7
		y_input *= 0.7
	
	acceleration = Vector2(x_input, y_input) * ACC
	decceleration = Vector2(0.0, 0.0)
	
	if x_input == 0:
		if velocity.x > 0:
			decceleration.x = -ACC
		if velocity.x < 0:
			decceleration.x = ACC
	
	if y_input == 0:
		if velocity.y > 0:
			decceleration.y = -ACC
		if velocity.y < 0:
			decceleration.y = ACC
	
	if decceleration.x != 0 and decceleration.y != 0:
		decceleration *= 0.7
	
	if Input.is_action_just_pressed("p1_use") and current_target != null:
		current_target.interacting = not current_target.interacting
	
func handle_selection():
	var new_selection = selector.get_overlapping_bodies()
	
	if len(new_selection) != 0:
		if len(new_selection) == 1:
			if new_selection[0] != current_target and current_target != null:
				current_target.selected = false
		elif not current_target in new_selection:
			if current_target != null:
				current_target.selected = false
		
		if new_selection[0].is_in_group("player_selectable"):
				current_target = new_selection[0]
				current_target.selected = true
	elif current_target != null:
		current_target.selected = false
		current_target = null
