extends Node

@onready var character: CharacterBody3D = get_parent()

@export var speed := 3.0
@export var acceleration := 20.0
@export var deceleration := 10.0

# moves a characterbody3d given a desired movement vector (usually normalized)
func move(input_vector: Vector2, delta: float) -> void:
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta
	
	if input_vector.length() > 0.1:
		character.velocity.x += input_vector.x * acceleration * delta
		character.velocity.z += input_vector.y * acceleration * delta
	else:
		var h := Vector2(character.velocity.x, character.velocity.z)
		h = h.limit_length(maxf(0, h.length() - deceleration * delta))
		character.velocity.x = h.x
		character.velocity.z = h.y
	
	var h := Vector2(character.velocity.x, character.velocity.z).limit_length(speed)
	character.velocity.x = h.x
	character.velocity.z = h.y
