extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var grabbed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if not is_on_floor() and not grabbed:
		velocity.y += gravity * delta
	if grabbed and not Input.is_key_pressed(KEY_B):
		grabbed = false
		global_position.x += 32
		set_collision_layer_value(1, true)
		set_collision_mask_value(1, true)
	if not grabbed:
		move_and_slide()

func _on_player_try_to_carry_anvil(position):
	grabbed = true
	global_position = position
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)

func throw_anvil(): 
	pass

