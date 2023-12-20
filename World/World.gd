extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$World_generator.connect("place_node", _on_place_node)

func _exit_tree():
	Global.world = null

func _on_place_node(node, location):
	#print("placing")
	#print(global_position)
	var node_instance = node.instantiate()
	add_child(node_instance)
	node_instance.global_position = location
