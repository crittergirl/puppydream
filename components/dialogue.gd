@tool
extends Label3D

@export var color := Color.WHITE:
	set(value): modulate = value
	get(): return modulate

@export var outline := Color.BLACK:
	set(value): outline_modulate = value
	get(): return outline_modulate

@export_multiline("dialogue") var lines := "...":
	set(value):
		lines = value
		var size := lines.split('\n').size()
		idx = min(idx, size-1)

@export var idx := 0:
	set(value):
		value %= lines.split('\n').size()
		idx = value
		text = lines.split('\n')[idx]

func _ready() -> void:
	next()
	%linetimer.start()

func _on_linetimer_timeout() -> void:
	next()

func next() -> void:
	if Engine.is_editor_hint():
		idx += 1
	else:
		idx = randi_range(0, lines.split('\n').size())
		%linetimer.wait_time = randi_range(3, 180) # i'm not kidding
