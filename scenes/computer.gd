extends "res://scripts/box.gd"

enum Status {FREE,BUSY,VIRUS}

@onready var connections=[]
@onready var status=Status.FREE
@onready var virus_timer=$VirusTimer
func start(adjacency):
	connections=adjacency

func virus():
	status=Status.BUSY
	


	
