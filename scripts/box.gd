extends StaticBody2D

var selected = false : set = _set_select

func _set_select(new_value):
	if not new_value is bool: return
	if new_value:
		modulate.r = 0.5
		modulate.b = 0.5
	else:
		modulate.r = 1.0
		modulate.b = 1.0
	selected = new_value

func _ready():
	add_to_group("player_selectable")
	collision_mask = 0b00000000_00000000_00000000_00000011
	collision_layer = 0b00000000_00000000_00000000_00000011
