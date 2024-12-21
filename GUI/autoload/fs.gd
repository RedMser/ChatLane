extends Object
class_name FS


static func normalize_path(path: String) -> String:
	if OS.has_feature("windows"):
		return path.replace("/", "\\")
	else:
		return path.replace("\\", "/")


static func get_registry_value(key: String, value: String) -> String:
	if not OS.has_feature("windows"):
		push_error("Registry only works on Windows.")
		return ""
	var tp = ThreadedProcess.new()
	tp.execute("reg", PackedStringArray(["query", key, "/v", value]), true)
	Engine.get_main_loop().root.add_child(tp)
	var result = await tp.done
	
	var exit_code = result[0]
	var output = result[1]
	if exit_code == 1:
		return ""
	elif exit_code != 0:
		push_error("Unexpected error getting registry value (exit code %d): %s" % [exit_code, output])
		return ""
	
	var regex = RegEx.create_from_string("(?m)^\\s*%s\\s+REG_[A-Z]+\\s+(.+?)\\s*$" % value)
	for ln in "\n".join(output).split("\n"):
		var matches = regex.search(ln)
		if matches == null: continue
		return matches.get_string(1)
	return ""


static func get_temp_file_access(name: String, keep := false, access = FileAccess.WRITE) -> FileAccess:
	assert(!name.is_empty())
	var filename = name.get_basename()
	var extension = name.get_extension()
	assert(!extension.is_empty())
	return FileAccess.create_temp(access, "chatlane-" + filename, extension, keep)


static func get_temp_file_path(name: String) -> String:
	assert(!name.is_empty())
	var filename = name.get_basename()
	var extension = name.get_extension()
	assert(!extension.is_empty())
	return OS.get_temp_dir().path_join("chatlane-" + filename + "." + extension)


static func get_installation_path() -> String:
	if OS.has_feature("editor"):
		return ProjectSettings.globalize_path("res://")
	else:
		return OS.get_executable_path().get_base_dir()
