extends Path3D

func _ready() -> void:
	while curve.point_count < 2:
		curve.add_point(Vector3.ZERO)

func _process(delta: float) -> void:
	var a: Vector3 = to_local(%leashpointa.global_position)
	var b: Vector3 = to_local(%leashpointb.global_position)
	curve.set_point_position(0, a)
	curve.set_point_position(1, b)
