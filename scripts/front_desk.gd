extends "res://scripts/box.gd"

@export var line_interval: float = 5.0
@export var max_clients: int = 4
@export var client_prefab: PackedScene

@onready var client_spawn = $ClientSpawn

var line = []

func _ready():
	super._ready()
	add_to_line()

func add_to_line():
	while(visible):
		await get_tree().create_timer(line_interval).timeout
		if(len(line) < max_clients):
			
			# instantiate line object here
			var obj = client_prefab.instantiate()
			var obj_sprite = obj.get_node("Sprite2D")
			var distance_between_objs = (obj_sprite.texture.get_height() * obj_sprite.scale.y) + 1
			
			
			get_parent().add_child(obj)
			
			obj.global_position = client_spawn.global_position
			obj.global_position.y -= (distance_between_objs * len(line))
			obj.target_position = obj.global_position
			
			
			line.append(obj)
			
func use():
	var teste
	if len(line) > 0 and object_state==interacting_object.State.FREE:
		# destroys clients in line, fix later
		line[0].current_state = line[0].State.FOLLOW
		line[0].interacting_object=interacting_object
		interacting_object.state=interacting_object.State.GUIDING
		interacting_object.guided_customer=line[0]
		
		line.pop_at(0)
		for i in range(len(line)):
			line[i].target_position = client_spawn.global_position
			var line_sprite = line[i].get_node("Sprite2D")
			var distance_between_objs = (line_sprite.texture.get_height() * line_sprite.scale.y) + 1
			
			line[i].target_position.y -= ((distance_between_objs) * i)
			#line[i].global_position = client_spawn.global_position
			#line[i].global_position.y -= ((line[i].get_node("Sprite2D").texture.get_height() / 2 + 1) * i)


