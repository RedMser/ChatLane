extends Node


var is_first_launch: bool


func _ready():
	check_first_launch()
	
	# defer due to "parent node is busy"
	await get_tree().process_frame
	
	if is_first_launch:
		get_tree().change_scene_to_file("res://language_selector.tscn")
	else:
		get_tree().change_scene_to_file("res://root.tscn")


func check_first_launch():
	if OS.has_feature("debug"):
		# testing purposes
		is_first_launch = true
		return
	
	const first_launch_file = "user://first_launch"
	
	if FileAccess.file_exists(first_launch_file):
		is_first_launch = false
	else:
		is_first_launch = true
		FileAccess.open(first_launch_file, FileAccess.WRITE)
