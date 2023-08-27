extends Node

@onready var max_virus_timer=$MaxVirusTimer
@onready var virus_timer=$VirusTimer

@onready var recent_virus=false
	

func spawn_virus():
	var computers=$Computers.get_children()
	randomize()
	var i=randi()%(computers.size())
	computers[i].virus("network")

func _on_max_virus_timer_timeout():
		spawn_virus()


func _on_virus_timer_timeout():
	randomize()
	var i =0#randi()%10
	if i==0:# 10% de chance
		spawn_virus()
		max_virus_timer.start()


