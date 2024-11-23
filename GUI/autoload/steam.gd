extends Node


var _steam_installation
var _deadlock_installation


func find_steam_installation() -> String:
	if _steam_installation != null:
		return _steam_installation
	
	const common_paths = [
		# Windows
		"C:\\Program Files (x86)\\Steam\\",
		# TODO: Other OSes (likely hidden behind OS.has_feature checks)
	]
	
	for path in common_paths:
		if _try_steam_installation(path):
			_steam_installation = path
			return _steam_installation
	
	var registry = await FS.get_registry_value("HKCU\\Software\\Valve\\Steam", "SteamPath")
	if not registry.is_empty():
		registry = FS.normalize_path(registry)
		if _try_steam_installation(registry):
			_steam_installation = registry
			return _steam_installation
	
	_steam_installation = ""
	return _steam_installation


func _try_steam_installation(path: String) -> bool:
	# Since the executable path depends on the OS, we use some "commonly found" folders.
	return DirAccess.dir_exists_absolute(path.path_join("config")) and \
		DirAccess.dir_exists_absolute(path.path_join("userdata"))


func find_deadlock_installation() -> String:
	if _deadlock_installation != null:
		return _deadlock_installation
	
	var steam = await find_steam_installation()
	if steam.is_empty():
		push_error("Unable to locate Steam installation.")
		_deadlock_installation = ""
		return _deadlock_installation
	
	const install_paths = [
		"steamapps/common/Project8", # TODO: is this how the folder was called in the past?
		"steamapps/common/Deadlock",
	]
	
	# check library folders
	var library_folders_path = steam.path_join("config/libraryfolders.vdf")
	var library_folders = get_library_folders(FileAccess.get_file_as_string(library_folders_path))
	var library_folders_open_error = FileAccess.get_open_error()
	if library_folders_open_error != OK:
		push_error("Unable to open ", library_folders_path, ": ", error_string(library_folders_open_error))
	
	# if we have no library folders, still try the steam folder
	if library_folders.is_empty():
		library_folders.append(steam)
	
	for library_folder in library_folders:
		for install_path in install_paths:
			var path = FS.normalize_path(library_folder.path_join(install_path))
			if _try_deadlock_installation(path):
				_deadlock_installation = path
				return _deadlock_installation
	
	push_error("Unable to find Deadlock installation.")
	_deadlock_installation = ""
	return _deadlock_installation


func _try_deadlock_installation(path: String) -> bool:
	return FileAccess.file_exists(path.path_join("game/citadel/gameinfo.gi"))


func get_library_folders(library_folders_vdf: String) -> PackedStringArray:
	# Cursed ""parsing"" of VDF
	var regex = RegEx.create_from_string("(?m)^\\s*\"path\"\\s+\"(.+)\"\\s*$")
	var matches = regex.search_all(library_folders_vdf)
	# Let's hope that escape sequences are similar enough to what Godot uses via c_unescape
	return matches.map(func(m): return m.get_string(1).c_unescape())
