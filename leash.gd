extends Path3D

func _ready() -> void:
	while curve.point_count < 2:
		curve.add_point(Vector3.ZERO)

func _process(delta: float) -> void:
	var a: Vector3 = %leashpointa.global_position
	var b: Vector3 = %leashpointb.global_position
	var mid := a + (b-a)/2 + Vector3.DOWN * 0.1
	
	curve.set_point_position(0, to_local(a))
	curve.set_point_position(1, to_local(b))
	
	curve.set_point_out(0, to_local(mid) - to_local(a))
	curve.set_point_in(1, to_local(mid) - to_local(a))
