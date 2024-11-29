@tool
extends Control

@export var radius_multiplier: float = 1.0:
	set(value):
		radius_multiplier = value
		if is_node_ready():
			for entry in get_children():
				entry.radius_multiplier = value
				entry.update()
@export_multiline var entries: Array[String]
@export var click_to_activate := false
@export var active_index := -1:
	set(value):
		active_index = value
		if is_node_ready():
			var i = 0
			for entry in get_children():
				entry.is_active = value == i
				entry.update()
				i += 1

var previous_entries: int = entries.size()


signal entry_pressed(index: int)


func _ready() -> void:
	set_process(Engine.is_editor_hint())
	regenerate_entries()


func _process(delta: float) -> void:
	if previous_entries != entries.size():
		previous_entries = entries.size()
		regenerate_entries()
	else:
		var i := 0
		for entry in get_children():
			entry.text = entries[i]
			entry.radius_multiplier = radius_multiplier
			i += 1


func regenerate_entries() -> void:
	for entry in get_children():
		remove_child(entry)
		entry.queue_free()
	
	var entry_rotation := 0.0
	
	var i = 0
	for entry in entries:
		var wheel_entry := preload("res://wheel_preview/wheel_entry.tscn").instantiate()
		wheel_entry.text = entry
		wheel_entry.entries = entries.size()
		wheel_entry.rotation = entry_rotation
		wheel_entry.radius_multiplier = radius_multiplier
		wheel_entry.pressed.connect(_on_wheel_entry_pressed.bind(i))
		add_child(wheel_entry)
		
		entry_rotation += TAU / float(entries.size())
		i += 1


func _on_wheel_entry_pressed(index: int):
	if click_to_activate:
		active_index = index
	entry_pressed.emit(index)
