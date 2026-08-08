extends CharacterBody3D

var move_speed := 3.0

var camera_bobbing_t := 0.0

func _process(delta: float) -> void:
	var camera_position := Vector3(0, 0.1, 0) # local
	
	# camera bobbing + breathing
	camera_position.y += sin(camera_bobbing_t * 20) * 0.01
	if Vector2(velocity.x, velocity.z).length() > 0.1:
		camera_bobbing_t += delta
	else:
		camera_bobbing_t += delta * 0.1
	
	var owner_direction: Vector3 = (%target.global_position - %camera.global_position).normalized()
	var camera_direction: Vector3 = (-%camera.global_basis.z).slerp(owner_direction, 5 * delta)
	
	%camera.global_position = to_global(camera_position)
	%camera.look_at(%camera.global_position + camera_direction)

func _physics_process(delta: float) -> void:
	
	# if too far away from owner, teleport to breadcrumb
	if global_position.distance_to(%owner.global_position) > 10.0:
		global_position = %breadcrumb1.global_position
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# pull leash in if owner is higher or lower, makes ramps easier
	var leash_length := 1.2
	if absf(%owner.global_position.y - global_position.y) > 0.05:
		leash_length = 0.5
	if Input.is_action_pressed("pull"):
		leash_length = 0.3
	
	var movement := Vector2.ZERO
	var leash_vector_3d: Vector3 = %owner.global_position - global_position
	if leash_vector_3d.length() > leash_length:
		movement = Vector2(leash_vector_3d.x, leash_vector_3d.z).normalized()
	$charactermovement.move(movement, delta)
	
	move_and_slide()
