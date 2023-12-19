extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("yo")
	#var character = get_node("CharacterBody2D")
	#character.timeout.connect(updateCoords)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateCoords(x, y):
	position.x = x;
	position.y = y;
