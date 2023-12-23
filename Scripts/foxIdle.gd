extends State
class_name foxIdle

@export var npc: CharacterBody2D
@export var move_speed := 25.0

var move_direction : Vector2
var wander_time : float

func random_movement():
	move_direction = Vector2(randf_range(-1,1), 0.0)
	wander_time = randf_range(1, 3)
	

func Enter(): 
	random_movement()

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	
	else:
		random_movement()

func Physics_Update(delta: float):
	if npc:
		npc.velocity = move_direction * move_speed
