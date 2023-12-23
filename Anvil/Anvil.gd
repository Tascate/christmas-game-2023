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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_gravity() -> float:
	return throw_gravity if velocity.y < 0.0 else gravity

func _physics_process(delta):
	move_and_slide()
