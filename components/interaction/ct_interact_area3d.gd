extends Area3D
class_name CT_InteractArea3D

signal on_interacted(by: CT_InteractRay3D)

func _interacted(raycast: CT_InteractRay3D) -> void:
	on_interacted.emit(raycast)
