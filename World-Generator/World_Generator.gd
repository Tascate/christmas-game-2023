extends Marker2D

@export var block : PackedScene

@export var min_distance_between_objects : int
@export var max_distance_between_objects : InternalMode
@export var max_world_distance : int
var current_distance = 0;

@export var grid_size: int

signal place_node(node, location)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (current_distance < max_world_distance):
		print(global_position)
		global_position.x += grid_size
		emit_signal("place_node", block, global_position)
		current_distance += 1
	else:
		queue_free()
