extends Node

signal files_dropped(files: PackedStringArray)


func _ready() -> void:
	get_window().files_dropped.connect(func(files): files_dropped.emit(files))
