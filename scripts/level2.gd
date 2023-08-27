extends Node2D

#@onready var next_level=preload("res://scenes/levels/level3.tscn")
@onready var computer1=$Network/Computers/computer
@onready var computer2=$Network/Computers/computer2
# Called when the node enters the scene tree for the first time.
func _ready():
	computer1.start([computer2])
	computer2.start([computer1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
