extends Marker2D

@export var block : PackedScene
@export var object : PackedScene

@export var min_distance_between_objects : int
@export var max_distance_between_objects : int
@export var max_world_distance : int
var current_distance = 0;
var distance_until_next_object = 1
var rng;

@export var grid_size: int

signal place_node(node, location)

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (current_distance < max_world_distance):
		global_position.x += grid_size
		var block_instance = block.instantiate();
		emit_signal("place_node", block_instance, global_position)
		if distance_until_next_object <= 0:
			#TODO randomize object to place
			var object_instance = object.instantiate()
			distance_until_next_object = object_instance.width / grid_size 
			distance_until_next_object += rng.randi_range(min_distance_between_objects, max_distance_between_objects)
			emit_signal("place_node", object_instance, global_position)
		current_distance += 1
		distance_until_next_object -= 1
	else:
		queue_free()
