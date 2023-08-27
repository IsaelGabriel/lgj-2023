extends Node

@onready var max_virus_timer=$MaxVirusTimer
@onready var virus_timer=$VirusTimer
@onready var computer1=$Computers/computer
@onready var computer2=$Computers/computer2
@onready var computer3=$Computers/computer3
@onready var computer4=$Computers/computer4
@onready var computer5=$Computers/computer5
@onready var recent_virus=false
 
func _ready():
	computer1.start([computer3])
	computer2.start([computer3])
	computer3.start([computer1,computer2,computer4,computer5])
	computer4.start([computer3])
	computer5.start([computer3])
	

func spawn_virus():
	var computers=$Computers.get_children()
	randomize()
	var i=randi()%(computers.size())
	computers[i].virus()

func _on_max_virus_timer_timeout():
		spawn_virus()


func _on_virus_timer_timeout():
	randomize()
	var i =randi()%10
	if i==0:# 10% de chance
		spawn_virus()
		max_virus_timer.start()


