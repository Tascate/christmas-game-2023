extends Sprite2D

signal picked_up

func _on_area_2d_body_entered(body):
	print("omg")
	if body is Player:
		picked_up.emit()
		queue_free()
