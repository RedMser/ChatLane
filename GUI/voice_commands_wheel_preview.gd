@tool
extends Control


@export var orientation := 0:
	set(value):
		orientation = value
		if is_node_ready():
			$InnerWheel.active_index = value
@export var magic_size_number := 300.0
@export var entries: Array[String] = []:
	set(value):
		entries = value
		if is_node_ready():
			update_entries()


func _ready() -> void:
	var def: Array[String] = []
	def.resize(12)
	def.fill("")
	$OuterWheel.entries = def
	resized.connect(update_size)
	update_size()
	update_entries()
	orientation = orientation
	set_process(Engine.is_editor_hint())


func _process(delta: float) -> void:
	update_size()
	update_orientation()


func update_size():
	var s = min(size.x, size.y)
	var factor = s / magic_size_number
	$InnerWheel.radius_multiplier = factor * 0.2
	$OuterWheel.radius_multiplier = factor * 0.315


func update_orientation():
	var step = 360.0 / 12.0
	var inner_step = 360.0 / 8.0
	var rot = (entries.size()-1) * (step / -2.0)
	rot += orientation * inner_step
	$OuterWheel.rotation_degrees = rot
	for entry in $OuterWheel.get_children():
		entry.update()


func update_entries():
	for i in 12:
		var txt = ""
		if i < entries.size():
			txt = entries[i]
		$OuterWheel.entries[i] = txt
	$OuterWheel.regenerate_entries()
	update_orientation()


func _on_inner_wheel_entry_pressed(index: int) -> void:
	orientation = index
	update_orientation()
