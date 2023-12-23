extends AnimatableBody2D
class_name Interactable

signal activated
signal deactivated

#signals a connected object about its activation status
func activate():
	activated.emit()
	
func deactivate():
	deactivated.emit()
