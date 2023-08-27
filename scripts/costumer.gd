extends "res://scripts/box.gd"

const MIN_FOLLOW_DISTANCE: float = 64

enum State {LINE, FOLLOW, USE_PC, LEAVE}

@onready var collider = $CollisionShape2D

@onready var current_state: State = State.LINE :
	set(new_state):
		if new_state == current_state or not new_state is State: return
		current_state = new_state

var player

func _ready():
	super()
	player = get_parent().get_node("Player")
	collision_mask = 0b10
	collision_layer = 0b10

func _process(delta):
	super(delta)
	match current_state:
		State.LINE:
			process_line(delta)
		State.FOLLOW:
			process_follow(delta)

func process_line(delta):
	pass

func process_follow(delta):
	var target_position = player.position - player.current_direction * MIN_FOLLOW_DISTANCE
	
	var normalized_position = (target_position - position).normalized()
	await get_tree().create_timer(0.2)
	position += normalized_position * delta * player.SPEED
	if position.distance_to(target_position) < 2:
		position = target_position
	#if position.distance_to(target_position) < MIN_FOLLOW_DISTANCE:
	#	normalized_position = (position - player.position).normalized()
	#	position = player.position + normalized_position * MIN_FOLLOW_DISTANCE
