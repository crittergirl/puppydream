extends CharacterBody3D

var move_speed := 3.0

func _process(delta: float) -> void:
	var owner_direction: Vector3 = (%owner.global_position - global_position).normalized()
	if (-%camera.global_basis.z).angle_to(owner_direction):
		var look_vector: Vector3 = (-%camera.global_basis.z).slerp(owner_direction, 20.0 * delta)
		%camera.look_at(%camera.global_position + look_vector)
	#%camera.look_at(%target.global_position)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# pull leash in if owner is higher or lower, makes ramps easier
	var leash_length := 1.2
	if absf(%owner.global_position.y - global_position.y) > 0.05:
		leash_length = 0.5
	
	var movement := Vector2.ZERO
	var leash_vector_3d: Vector3 = %owner.global_position - global_position
	if leash_vector_3d.length() > leash_length:
		movement = Vector2(leash_vector_3d.x, leash_vector_3d.z).normalized()
	$charactermovement.move(movement, delta)
	
	move_and_slide()
