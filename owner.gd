extends CharacterBody3D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# face the direction of the camera
	global_rotation.y = %camera.global_rotation.y
	
	var input := Input.get_vector("move_left", "move_right", "move_forward", "move_back").normalized()
	$charactermovement.move(input.rotated(-global_rotation.y), delta)
	
	move_and_slide()
