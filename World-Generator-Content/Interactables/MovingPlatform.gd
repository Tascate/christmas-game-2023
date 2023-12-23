extends Node2D

@export var trigger_interactable : Interactable
@export var speed = 2.0
@export var speed_scale = 1.0

@onready var pathfollow = $PathFollow2D
@onready var animation = $AnimationPlayer

var toggled = false

func _ready():
	trigger_interactable.toggled.connect(toggle)
	
func toggle():
	print("omg we go")
	toggled = !toggled
	if toggled:
		animation.play("moving")
	else:
		animation.play_backwards("moving")
