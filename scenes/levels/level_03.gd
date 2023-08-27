extends Node2D
@onready var next_level

var computers =[]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1,16):
		computers.append(get_node("Network/Computers/computer%d" % i))
		
	computers[0].start(computers[1], computers[2], computers[3])
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
