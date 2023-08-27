extends "res://scripts/box.gd"

const MIN_FOLLOW_DISTANCE: float = 64

enum State {LINE, FOLLOW, USE_PC, LEAVE}

var target_position = Vector2(0, 0)
var last_direction = Vector2.DOWN
var moving = false

@onready var collider = $CollisionShape2D
@onready var animator = $AnimationPlayer
@onready var sprite = $Sprite2D

@onready var current_state: State = State.LINE :
	set(new_state):
		if new_state == current_state or not new_state is State: return
		current_state = new_state
const SPEED = 100.0

func _ready():
	interaction_duration=10.0
	super()
	collision_mask = 0b00
	collision_layer = 0b00
	

func _process(delta):
	super(delta)
	match current_state:
		State.LINE:
			process_line(delta)
		State.FOLLOW:
			process_follow(delta)
		State.USE_PC:
			process_use_pc(delta)
	handle_animation()

func handle_animation():
	var suffix = "walk" if moving else "idle"
	var dir = "up" if last_direction == Vector2.UP else ("down" if last_direction == Vector2.DOWN else "side")

	animator.play("customer_%s_%s" % [suffix, dir])
	
	sprite.flip_h = last_direction == Vector2.LEFT

func process_line(delta):
	var normalized_position = (target_position - global_position).normalized()
	await get_tree().create_timer(0.2)
	global_position += normalized_position * delta * SPEED
	moving = true
	if global_position.distance_to(target_position) < 2:
		global_position = target_position
		moving = false

func process_follow(delta):
	if interacting_object!=null:
		
		target_position = interacting_object.position - interacting_object.current_direction * MIN_FOLLOW_DISTANCE
		
		var normalized_position = (target_position - position).normalized()
		await get_tree().create_timer(0.2)
		
		set_direction(normalized_position)
		
		position += normalized_position * delta *SPEED
		moving = true
		if position.distance_to(target_position) < 2:
			position = target_position

func process_use_pc(delta):
	if interacting_object!=null:
		
		target_position = interacting_object.position - interacting_object.current_direction * MIN_FOLLOW_DISTANCE
		
		var normalized_position = (target_position - position).normalized()
		await get_tree().create_timer(0.2)
		
		set_direction(-interacting_object.current_direction)
		
		position += normalized_position * delta * SPEED
		moving = true
		if position.distance_to(target_position) < 2:
			position = target_position
			moving = false

	#if position.distance_to(target_position) < MIN_FOLLOW_DISTANCE:
	#	normalized_position = (position - player.position).normalized()
	#	position = player.position + normalized_position * MIN_FOLLOW_DISTANCE

func set_direction(normalized: Vector2):
	if abs(normalized.x) > abs(normalized.y):
		if normalized.x > 0:
			last_direction = Vector2.RIGHT
		else:
			last_direction = Vector2.LEFT
	elif abs(normalized.y) > abs(normalized.x):
		if normalized.y > 0:
			last_direction = Vector2.DOWN
		else:
			last_direction = Vector2.UP

func use():
	interacting_object.status=interacting_object.Status.FREE
	queue_free()
	
	
