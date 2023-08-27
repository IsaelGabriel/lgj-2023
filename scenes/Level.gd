extends Node2D
@onready var next_level
@onready var computer1=$Network/Computers/computer
@onready var computer2=$Network/Computers/computer2
@onready var computer3=$Network/Computers/computer3
@onready var computer4=$Network/Computers/computer4
@onready var computer5=$Network/Computers/computer5
# Called when the node enters the scene tree for the first time.
func _ready():
	computer1.start([computer3])
	computer2.start([computer3])
	computer3.start([computer1,computer2,computer4,computer5])
	computer4.start([computer3])
	computer5.start([computer3])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
