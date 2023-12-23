extends CharacterBody2D

@export var throw_height : float
@export var throw_height_time_to_peak : float
@export var throw_horizontal_velocity : float
@export var throw_drag : float

@onready var player = get_parent().get_node("Player")
@onready var throw_vertical_velocity : float = ((2.0 * throw_height) / throw_height_time_to_peak) * -1.0
@onready var throw_gravity : float = ((-2.0 * throw_height) / (throw_height_time_to_peak * throw_height_time_to_peak)) * -1.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var grabbed = false
var rng

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()

func get_gravity() -> float:
	return throw_gravity if velocity.y < 0.0 else gravity

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta, true)
	if collision:
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			print("go away")
			collider.apply_central_impulse(collision.get_normal() * -1 * 200)
			collider.apply_torque_impulse(20000)
			collider.set_collision_layer_value(3, false)
			collider.set_collision_mask_value(3, false)
			velocity += collision.get_travel() - collision.get_remainder()
	move_and_slide()
