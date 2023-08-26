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

