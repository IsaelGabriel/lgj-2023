extends "res://scripts/box.gd"

@export var line_interval: float = 5.0
@export var max_clients: int = 4
@export var client_prefab: PackedScene

@onready var client_spawn = $ClientSpawn

var line = []

func _ready():
	add_to_line()

func add_to_line():
	while(visible):
		await get_tree().create_timer(line_interval).timeout
		if(len(line) < max_clients):
			
			# instantiate line object here
			var obj = client_prefab.instantiate()
			
			owner.add_child(obj)
			
			obj.global_position = client_spawn.global_position
			obj.global_position.y -= ((obj.get_node("Sprite2D").texture.get_height() / 2 + 1) * len(line))
			
			line.append(obj)
			
			print("Added! Clients in line: ", len(line))
