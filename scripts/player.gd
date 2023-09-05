extends CharacterBody2D

const SPEED = 300.0
const ACC = 275.0

var acceleration = Vector2(0, 0)
var deceleration = Vector2(0, 0) # Uses absolute values

func _process(delta):
	handle_input()

func _physics_process(delta):
	if(deceleration.x != 0):
		if(velocity.x > 0):
			velocity.x -= delta * deceleration.x
			velocity.x = clampf(velocity.x, 0, SPEED)
		elif(velocity.x < 0):
			velocity.x += delta * deceleration.x
			velocity.x = clamp(velocity.x, -SPEED, 0)
	
	if(deceleration.y != 0):
		if(velocity.y > 0):
			velocity.y -= delta * deceleration.y
			velocity.y = clampf(velocity.y, 0, SPEED)
		elif(velocity.y < 0):
			velocity.y += delta * deceleration.y
			velocity.y = clampf(velocity.y, -SPEED, 0)
	
	velocity += delta * acceleration
	velocity = velocity.normalized() * clampf(velocity.length(), -SPEED, SPEED)
	move_and_slide()
	

func handle_input():
	var inp: Vector2 = Vector2(Input.get_axis("p1_left", "p1_right"), Input.get_axis("p1_up", "p1_down"))
	acceleration = Vector2(0, 0)
	deceleration = Vector2(0, 0)
	
	if(inp.length() != 0):
		inp = inp.normalized()
		
		if(velocity != inp * SPEED):
			acceleration = inp * ACC
			if(velocity.x != 0):
				if(((inp.x > 0) != (velocity.x > 0)) and inp.x != 0):
					acceleration.x = 0
					deceleration.x = ACC * 3
				elif(inp.x == 0):
					deceleration.x = ACC * 3
			if(velocity.y != 0):
				if(((inp.y > 0) != (velocity.y > 0)) and inp.y != 0):
					acceleration.y = 0
					deceleration.y = ACC * 1.75
				elif(inp.y == 0):
					deceleration.y = ACC * 3
					
	elif(velocity.length() != 0):
		if(velocity.x != 0):
			deceleration.x = ACC * 3
		if(velocity.y != 0):
			deceleration.y = ACC * 3
	acceleration = acceleration.normalized() * ACC
	deceleration = deceleration.normalized() * ACC * 1.75
