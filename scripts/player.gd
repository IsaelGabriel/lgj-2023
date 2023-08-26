extends CharacterBody2D

const SPEED = 50.0

func _process(_delta):
	var x_input = 0.0
	if Input.is_action_pressed("p1_left"): x_input += -1
	if Input.is_action_pressed("p1_right"): x_input += 1

	var y_input = 0.0
	if Input.is_action_pressed("p1_up"): y_input += -1
	if Input.is_action_pressed("p1_down"): y_input += 1
	
	velocity = Vector2(x_input, y_input) * SPEED
	
func _physics_process(_delta):
	move_and_slide()
