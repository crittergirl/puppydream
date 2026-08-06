extends CharacterBody3D

var input := Vector2.ZERO # keyboard movement input

func _ready() -> void:
	# wait until now to set top_level so they can be moved properly while in editor
	%breadcrumb1.top_level = true
	%breadcrumb2.top_level = true

func _process(delta: float) -> void:
	
	# interpolate sprite position to physics position to stop jittering
	%sprite.top_level = true
	%sprite.global_position = lerp(%sprite.global_position, global_position + Vector3.UP * 0.325, 30 * delta)
	
	# rotate sprite according to movement for juice
	var target_rotation := global_rotation.y # BUG? assumes owner is always vertical
	if input.x < 0:
		target_rotation += TAU * 0.1
	elif input.x > 0:
		target_rotation -= TAU * 0.1
	
	# interpolate sprite rotation to physics rotation to stop jittering
	%sprite.global_rotation.y = lerp_angle(%sprite.global_rotation.y, target_rotation, 30 * delta)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# face the direction of the camera
	global_rotation.y = %camera.global_rotation.y
	
	input = Input.get_vector("move_left", "move_right", "move_forward", "move_back").normalized()
	$charactermovement.move(input.rotated(-global_rotation.y), delta)
	
	move_and_slide()

# repeatedly teleport breadcrumb to owner if it's too far away
# we use 2 breadcrumbs so that at least one of them isn't inside the owner
func _on_breadcrumbtimer_timeout() -> void:
	if %breadcrumb2.global_position.distance_to(global_position) > 0.5:
		%breadcrumb1.global_position = %breadcrumb2.global_position
		%breadcrumb2.global_position = global_position
