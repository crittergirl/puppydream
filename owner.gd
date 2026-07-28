extends CharacterBody3D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# face the direction of the camera
	global_rotation.y = %camera.global_rotation.y
	
	var input := Input.get_vector("move_left", "move_right", "move_forward", "move_back").normalized()
	$charactermovement.move(input.rotated(-global_rotation.y), delta)
	
	move_and_slide()

# repeatedly teleport breadcrumb to owner if it's too far away
# we use 2 breadcrumbs so that at least one of them isn't inside the owner
func _on_breadcrumbtimer_timeout() -> void:
	if %breadcrumb2.global_position.distance_to(global_position) > 0.5:
		%breadcrumb1.global_position = %breadcrumb2.global_position
		%breadcrumb2.global_position = global_position
