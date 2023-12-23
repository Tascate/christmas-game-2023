extends State
class_name AnvilGrabbed

@export var anvil : CharacterBody2D

func Enter():
	anvil.velocity.x = 0
	anvil.velocity.y = 0
	anvil.set_collision_layer_value(3, false)
	anvil.set_collision_mask_value(3, false)
	print(anvil.player)
	anvil.player.player_grab_anvil.connect(_on_player_grab_anvil)
	print("connected")

func Exit():
	anvil.player.player_grab_anvil.disconnect(_on_player_grab_anvil)
	anvil.set_collision_layer_value(3, true)
	anvil.set_collision_mask_value(3, true)
	anvil.velocity.x = anvil.throw_horizontal_velocity + anvil.player.velocity.x
	anvil.velocity.y = anvil.throw_vertical_velocity
	

func Physics_Update(delta: float):
	if not Input.is_key_pressed(KEY_Z):
		Transitioned.emit(self, "AnvilAir")

func _on_player_grab_anvil(position):
	anvil.global_position = position
