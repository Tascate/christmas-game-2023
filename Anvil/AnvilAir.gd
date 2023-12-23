extends State
class_name AnvilAir

@export var anvil: CharacterBody2D

func Enter(): 
	pass

func Exit():
	#TODO Apply forces to nearby Rigidbodies
	#TODO Activates nearby interactables
	anvil.velocity.x = 0
	pass

func Physics_Update(delta: float):
	if Input.is_key_pressed(KEY_Z):
		Transitioned.emit(self, "AnvilGrabbed")
	elif anvil.is_on_floor():
		Transitioned.emit(self, "AnvilGrounded")
	else:
		anvil.velocity.y += anvil.get_gravity() * delta
		anvil.velocity.x = lerp(anvil.velocity.x, 0.0, anvil.throw_drag * delta)
