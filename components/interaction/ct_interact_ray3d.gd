extends RayCast3D
class_name CT_InteractRay3D

@export var entity: Node3D

func _ready() -> void:
	SimusNetRPC.register(
		[_interact_rpc]
	)
	
	if entity is CollisionObject3D:
		add_exception(entity)
	
	
	set_process_input(SimusNet.is_network_authority(self))

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		interact()

func interact() -> void:
	if SimusNet.is_network_authority(self):
		SimusNetRPC.invoke_all(_interact_rpc)

func _interact_rpc() -> void:
	if get_collider():
		SD_Nodes.call_method_if_exists(get_collider(), "_interacted", [self])
