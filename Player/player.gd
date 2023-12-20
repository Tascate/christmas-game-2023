extends CharacterBody2D

@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float
@export var dash_speed : float
@export var dash_duration : float
@export var wavedash_speed : float
@export var wavedash_duration : float
@export var wavedash_friction : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
var is_dashing : bool = false
var dash_timer : float
var is_wavedashing : bool = false
var wavedash_timer : float

@export var move_speed : float

signal try_to_carry_anvil(position)

func get_dash_direction() -> float:
	return Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += get_gravity() * delta

	#Carry anvil
	if Input.is_key_pressed(KEY_B):
		try_to_carry_anvil.emit(global_position)
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, 0.5 * delta)  # Adjust the second parameter for smoother deceleration

    # Wavedash
	if Input.is_action_just_pressed("ui_dash") and not is_dashing and is_on_floor():
		print("WAVEDASHING !!!!!!!!!!!!!!!!!!")
		is_wavedashing = true
		wavedash_timer = wavedash_duration
		# Reset velocity before wavedash
		velocity.x = 0.0
	
	if is_wavedashing:
		print("Wavedashing...")
		# Gradually apply wavedash speed over wavedash duration
		velocity.x = lerp(velocity.x, get_dash_direction() * wavedash_speed, delta / wavedash_duration)
		wavedash_timer -= delta
		if wavedash_timer <= 0.0:
			is_wavedashing = false
			# Reset velocity after wavedash completes
			velocity.x = 0.0

	# dash
	if Input.is_action_just_pressed("ui_dash") and not is_dashing and not is_on_floor():
		print("DASHING !!!!!!!!!!!!!!!!!!!!!")
		is_dashing = true
		dash_timer = dash_duration
		# Reset velocity before dashing
		velocity.x = 0.0
		
	if is_dashing:
		print("Dashing...")
		# Gradually apply dash speed over dash duration
		velocity.x = lerp(velocity.x, get_dash_direction() * dash_speed, delta / dash_duration)
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
			# Reset velocity after dash completes
			velocity.x = 0.0


	move_and_slide()
