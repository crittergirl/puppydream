extends CharacterBody3D

var move_speed := 3.0

func _process(delta: float) -> void:
	%camera.look_at(%target.global_position)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# pull leash in if owner is higher or lower, makes ramps easier
	var leash_length := 0.8
	if absf(%owner.global_position.y - global_position.y) > 0.05:
		leash_length = 0.3
	
	var leash_vector_3d: Vector3 = %owner.global_position - global_position
	var leash_vector := Vector2(leash_vector_3d.x, leash_vector_3d.z)
	if leash_vector.length() > leash_length:
		velocity.x = (leash_vector.normalized() * move_speed).x
		velocity.z = (leash_vector.normalized() * move_speed).y
	else:
		velocity.x = 0
		velocity.z = 0
	
	move_and_slide()
