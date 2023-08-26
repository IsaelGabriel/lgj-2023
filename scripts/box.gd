extends StaticBody2D

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
	collision_mask = 0b00000000_00000000_00000000_00000011
	collision_layer = 0b00000000_00000000_00000000_00000011

func _process(delta):
	if interacting:
		interaction_count += delta
		print(interaction_duration - interaction_count)
		if interaction_count >= interaction_duration:
			use()
			interaction_count = 0.0
	elif interaction_count > 0.0:
		interaction_count -= delta / 2
		if interaction_count < 0.0: interaction_count = 0.0
	

func use():
	pass
