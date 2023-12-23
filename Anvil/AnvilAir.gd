extends State
class_name AnvilAir

@export var anvil: CharacterBody2D

func Enter(): 
	print("Aerial go")

func Exit():
	var shape_cast = ShapeCast2D.new()
	add_child(shape_cast)
	var shape = RectangleShape2D.new()
	shape.size = Vector2(200,50)
	shape_cast.shape = shape
	shape_cast.global_position = anvil.global_position
	shape_cast.force_shapecast_update()
	for n in 32:
		shape_cast.set_collision_mask_value(n+1, true)
	for n in shape_cast.get_collision_count():
		var collider = shape_cast.get_collider(n)
		if collider is RigidBody2D:
			print("got it")
			print(shape_cast.get_collision_normal(n))
			collider.apply_central_impulse(shape_cast.get_collision_normal(n) * -1 * 200)
			collider.apply_torque_impulse(10000)
		elif collider is Interactable:
			print("yo")
			collider.toggle()
	shape_cast.add_exception(anvil.player)
	
	shape_cast.queue_free()
	anvil.velocity.x = 0
	pass

func Physics_Update(delta: float):
	if Input.is_key_pressed(KEY_Z):
		Transitioned.emit(self, "AnvilGrabbed")
	elif anvil.is_on_floor():
		print("hello??")
		Transitioned.emit(self, "AnvilGrounded")
	else:
		anvil.velocity.y += anvil.get_gravity() * delta
		anvil.velocity.x = lerp(anvil.velocity.x, 0.0, anvil.throw_drag * delta)
