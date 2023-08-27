extends Control


@onready var label=$CenterContainer/HBoxContainer/Label
@export var goal : int = 100
@onready var points=0
func _ready(): 
	label.text="Goal: %d / %d"%[points,goal]
func update_point(value):
	points+=value
	if points>=goal:
		win()
	label.text="Goal: %d / %d"%[points,goal]

func win():
	get_tree().quit()
	
