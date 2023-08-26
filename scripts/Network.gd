extends Node


@onready var computer1=$computer
@onready var computer2=$computer2
@onready var computer3=$computer3
@onready var computer4=$computer4
@onready var computer5=$computer5

func _ready():
	computer1.start([computer3])
	computer2.start([computer3])
	computer3.start([computer1,computer2,computer4,computer5])
	computer4.start([computer3])
	computer5.start([computer3])
