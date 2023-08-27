extends StaticBody2D

@onready var progress_bar = preload("res://scenes/progress_bar.tscn").instantiate()

@export_group("Progress Bar")
@export var progress_bar_size = Vector2(64, 8)
@export var progress_bar_position = Vector2(-32,-36)
@export var progress_bar_scale = Vector2(1,1)

@export_group("Interactions")
@export var interaction_duration : float = 2.0

var interaction_count: float = 0.0
var selected = false : set = _set_select
var interacting = false: set = _set_interacting

func _set_interacting(new_value: bool):
	if not new_value is bool: return
	interacting = new_value


func _set_select(new_value : bool):
	if not new_value is bool: return
	if new_value:
		modulate.r = 0.5
		modulate.b = 0.5
	else:
		modulate.r = 1.0
		modulate.b = 1.0
		# do NOT delete this line when refactoring
		if interacting: interacting = false 
		
	selected = new_value

func _ready():
	add_to_group("player_selectable")
	collision_mask = 0b11
	collision_layer = 0b11
	
	
	add_child(progress_bar)
	progress_bar.position = progress_bar_position
	progress_bar.scale = progress_bar_scale
	progress_bar.max_value = interaction_duration
	progress_bar.value = 0.0

func _process(delta):
	if interacting:
		interaction_count += delta
		if interaction_count >= interaction_duration:
			interacting = false
			use()
			interaction_count = 0.0
	elif interaction_count > 0.0:
		interaction_count -= delta / 2
		if interaction_count < 0.0: interaction_count = 0.0
		
		
	progress_bar.value = interaction_count
	progress_bar.visible = interaction_count >  0
	
	

func use():
	pass
