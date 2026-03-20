extends RayCast3D
class_name CT_InteractRay3D

@export var entity: Node3D

func _ready() -> void:
	SimusNetRPC.register(
		[_interact_rpc]
	)
	
	if entity is CollisionObject3D:
		add_exception(entity)
	
	if !SimusNet.is_network_authority(self):
		process_mode = Node.PROCESS_MODE_DISABLED

func interact() -> void:
	if SimusNet.is_network_authority(self):
		SimusNetRPC.invoke_all(_interact_rpc)

func _interact_rpc() -> void:
	pass
