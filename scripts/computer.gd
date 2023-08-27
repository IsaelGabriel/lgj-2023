@tool
extends "res://scripts/box.gd"

enum Status {FREE,BUSY,VIRUS}
enum Direction {LEFT,RIGHT,UP,DOWN}

@onready var connections=[]
@onready var status=Status.FREE
@onready var virus_timer=$VirusTimer
@onready var imunity_timer=$ImunityTimer
@onready var sprite=$Sprite2D

# direction handling
@export var direction: Direction = Direction.DOWN
var current_direction

func _ready():
	super()
	match direction:
			Direction.DOWN:
				sprite.frame_coords.y = 0
				current_direction=Vector2(0,-1)
			Direction.UP:
				sprite.frame_coords.y = 2
				current_direction=Vector2(0,1)
			Direction.LEFT:
				sprite.frame_coords.y = 1
				current_direction=Vector2(1,0)
				sprite.flip_h=true
			Direction.RIGHT:
				sprite.frame_coords.y = 1
				current_direction=Vector2(-1,0)
				

	

func start(adjacency):
	connections=adjacency
	

func use(): #temporary for testing
	if status==Status.VIRUS:
		fix()
		if interacting_object!=null:
			interacting_object.interacting=true
		
	# removed in order to place clients
	#elif status==Status.FREE:
	#	virus()

func virus():
	if status==Status.BUSY and imunity_timer.is_stopped():
		status=Status.VIRUS
		virus_timer.start()
		sprite.frame_coords.x = 1
	if interacting_object!=null:
		interacting_object.interacting=false
	

func infect():
	randomize()
	var i=randi()%(connections.size())
	connections[i].virus()

func fix():
	if status==Status.VIRUS:
		status=Status.BUSY
		virus_timer.stop()
		sprite.frame_coords.x = 0
		imunity_timer.start()
	
	
func _on_virus_timer_timeout():
	infect()
	
func _set_interacting_object(new_value): #new_value will always be a player
	if status==Status.FREE and new_value:
		interacting_object=new_value.guided_costumer 
		interacting_object .interacting_object=self
		interacting_object.current_state=interacting_object.State.USE_PC     
		interacting_object.interacting=true     
		new_value.guided_costumer=null
		new_value.swap_state()
		status=Status.BUSY
		print("busy")
