extends Camera3D

@export var target_position := Vector3.ZERO # global coordinates
@export var target_direction := Vector3.FORWARD # also global; normalized

func update(pos: Vector3, look: Vector3) -> void:
	target_position = pos
	target_direction = look
	global_position = pos
	look_at(pos + look)

func _process(delta: float) -> void:
	return
	if global_position.distance_to(target_position):
		global_position = global_position.lerp(target_position, 20 * delta)
	
	if (-global_basis.z).angle_to(target_direction): # ??
		var look_vector: Vector3 = (-global_basis.z).slerp(target_direction, 20 * delta)
		look_at(global_position + look_vector)
