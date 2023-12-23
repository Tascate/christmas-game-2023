extends StaticBody2D

@export var trigger_interactable : Interactable

# Called when the node enters the scene tree for the first time.
func _ready():
	trigger_interactable.toggled.connect(_toggle_collision)

func _toggle_collision():
	$CollisionShape2D.disabled = not $CollisionShape2D.disabled
