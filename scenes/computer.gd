extends "res://scripts/box.gd"

enum Status {FREE,BUSY,VIRUS}

@onready var connections=[]
@onready var status=Status.FREE
@onready var virus_timer=$VirusTimer
func start(adjacency):
	connections=adjacency

func interact(): #temporary for testing
	if status==Status.VIRUS:
		fix()
	elif status==Status.FREE:
		virus()
func virus():
	status=Status.VIRUS
	virus_timer.start()

func infect():
	for i in connections:
		i.virus()

func fix():
	if status==Status.VIRUS:
		status=Status.FREE
		virus_timer.stop()
	
func _on_virus_timer_timeout():
	virus()
