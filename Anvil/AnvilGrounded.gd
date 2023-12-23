extends State
class_name AnvilGrounded

@export var anvil: CharacterBody2D

func Physics_Update(delta: float):
	if Input.is_key_pressed(KEY_Z):
		Transitioned.emit(self, "AnvilGrabbed")
	elif not anvil.is_on_floor():
		Transitioned.emit(self, "AnvilAir")
