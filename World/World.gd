extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$WorldGenerator.connect("place_node", _on_place_node)

func _on_place_node(node, location):
	add_child(node)
	node.global_position = location
