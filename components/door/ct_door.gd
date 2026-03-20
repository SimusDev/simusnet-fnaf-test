@tool
extends Area3D
class_name CT_Door

@export var status: bool = false : set = set_status

signal on_interacted_by(ray: CT_InteractRay3D)
signal on_status_changed()

func _ready() -> void:
	
	if Engine.is_editor_hint():
		return
	
	SimusNetVars.register(
		self, 
		[
			"status",
		], SimusNetVarConfig.new().flag_mode_server_only()
	)

func set_status(new: bool) -> CT_Door:
	await SD_Nodes.async_for_ready(self)
	status = new
	on_status_changed.emit()
	return self

func _interacted(by: CT_InteractRay3D) -> void:
	if SimusNetConnection.is_server():
		set_status(!status)
	
	on_interacted_by.emit(by)
