extends State
class_name playerAir

#in this state, the player can:
	#dash, jump, crouch (?)

@export var player: CharacterBody2D
var is_dashing : bool

var move_direction : Vector2

func Enter(): 
	pass

func Update(delta: float):
	pass

func Physics_Update(delta: float):
	print("airtime !!!!!!!!!!")
	if player.is_on_floor():
		Transitioned.emit(self, "playerGrounded")
	else:
		
		#gravity
		player.velocity.y += player.get_gravity() * delta
		
		# movement
		var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		if direction:
			player.velocity.x = player.get_dash_direction() * player.move_speed
		else:
			player.velocity.x = move_toward(player.velocity.x, 0, player.move_speed)
		player.velocity.x = lerp(player.velocity.x, 0.0, 0.5 * delta)  # Adjust the second parameter for smoother deceleration
		
		# dash
		if Input.is_action_just_pressed("ui_dash") and not is_dashing:
			print("dashing !!!!!!!!!!!!!!!!!!")
			is_dashing = true
			player.dash_timer = player.dash_duration
			# Reset velocity before dash
			player.velocity.x = 0.0
	
		if is_dashing:
			print("dashing...")
			# Gradually apply dash speed over dash duration
			player.velocity.x = lerp(player.velocity.x, player.get_dash_direction() * player.dash_speed, delta / player.dash_duration)
			player.dash_timer -= delta
			if player.dash_timer <= 0.0:
				is_dashing = false
				# Reset velocity after dash completes
				player.velocity.x = 0.0
