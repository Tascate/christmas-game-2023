extends State
class_name playerGrounded

#in this state, the player can:
	#dash, jump, crouch (?)

@export var player: CharacterBody2D
@export var anim: AnimatedSprite2D

var is_dashing : bool

var move_direction : Vector2

func Enter(): 
	pass

func Update(delta: float):
	pass

func Physics_Update(delta: float):
	if !player.is_on_floor():
		Transitioned.emit(self, "playerAir")
	else: 
		# movement
		var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		if direction:
			if direction < 0:
				anim.flip_h = false
			else:
				anim.flip_h = true
			anim.play("Run")
			player.velocity.x = player.get_dash_direction() * player.move_speed
		else:
			anim.play("Idle")
			player.velocity.x = move_toward(player.velocity.x, 0, player.move_speed)
		player.velocity.x = lerp(player.velocity.x, 0.0, 0.5 * delta)  # Adjust the second parameter for smoother deceleration
		
		# jump
		if Input.is_action_just_pressed("jump"):
			player.velocity.y = player.jump_velocity
			
		# wavedash
		if Input.is_action_just_pressed("ui_dash") and not is_dashing:
			#print("WAVEDASHING !!!!!!!!!!!!!!!!!!")
			is_dashing = true
			player.wavedash_timer = player.wavedash_duration
			# Reset velocity before wavedash
			player.velocity.x = 0.0
	
		if is_dashing:
			#print("Wavedashing...")
			# Gradually apply wavedash speed over wavedash duration
			player.velocity.x = lerp(player.velocity.x, player.get_dash_direction() * player.wavedash_speed, delta / player.wavedash_duration)
			player.wavedash_timer -= delta
			if player.wavedash_timer <= 0.0:
				is_dashing = false
				# Reset velocity after wavedash completes
				player.velocity.x = 0.0
