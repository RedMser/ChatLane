extends Object
class_name FS


static func get_temp_file_access(name: String, access = FileAccess.WRITE) -> FileAccess:
	return FileAccess.open("tmp://chatlane_" + str(randi()) + "_" + name, access)


static func get_temp_file_path(name: String, needs_write_permission := true) -> String:
	var fa = get_temp_file_access(name, FileAccess.WRITE if needs_write_permission else FileAccess.READ)
	var path = fa.get_path_absolute()
	fa.close()
	return path
