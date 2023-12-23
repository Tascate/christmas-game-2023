extends StaticBody2D
class_name Interactable

signal toggled
#signals a connected object about its activation status
func toggle():
	toggled.emit()

