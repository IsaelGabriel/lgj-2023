extends "res://scripts/box.gd"

enum Status {FREE,BUSY,VIRUS}

@onready var connections=[]
@onready var status=Status.FREE
@onready var virus_timer=$VirusTimer
@onready var imunity_timer=$ImunityTimer
@onready var sprite=$Sprite2D
func start(adjacency):
	connections=adjacency

func use(): #temporary for testing
	if status==Status.VIRUS:
		fix()
	elif status==Status.FREE:
		virus()

func virus():
	if status!=Status.VIRUS and imunity_timer.is_stopped():
		status=Status.VIRUS
		virus_timer.start()
		sprite.frame=1

func infect():
	randomize()
	var i=randi()%(connections.size())
	connections[i].virus()

func fix():
	if status==Status.VIRUS:
		status=Status.FREE
		virus_timer.stop()
		sprite.frame=0
		imunity_timer.start()
	
func _on_virus_timer_timeout():
	infect()
