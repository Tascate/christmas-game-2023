extends Marker2D

@export var block : PackedScene
@export var objects : Array[PackedScene]

@export var min_distance_between_objects : int
@export var max_distance_between_objects : int
@export var max_world_distance : int
var current_distance = 0;
var distance_until_next_object = 1
var rng;

@export var grid_size: int

signal place_node(node, location)

func _ready():
	rng = RandomNumberGenerator.new()

func _process(delta):
	if (current_distance < max_world_distance):
		global_position.x += grid_size
		var block_instance = block.instantiate();
		emit_signal("place_node", block_instance, global_position)
		if distance_until_next_object <= 0:
			var random_index = rng.randi_range(0, objects.size()-1)
			var object_instance = objects[random_index].instantiate()
			distance_until_next_object = object_instance.width / grid_size 
			distance_until_next_object += rng.randi_range(min_distance_between_objects, max_distance_between_objects)
			emit_signal("place_node", object_instance, global_position)
		current_distance += 1
		distance_until_next_object -= 1
	else:
		queue_free()
