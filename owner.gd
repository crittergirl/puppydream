extends CharacterBody3D

var move_speed := 5.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# face the direction of the camera
	global_rotation.y = %camera.global_rotation.y
	
	var input := Input.get_vector("move_left", "move_right", "move_forward", "move_back").normalized()
	if input:
		input = input.rotated(-global_rotation.y)
		velocity.x = input.x * move_speed
		velocity.z = input.y * move_speed
	else:
		velocity.x = 0
		velocity.z = 0
	
	move_and_slide()
