extends Node

func conversion(first_path: String, second_path: String) -> int:
	var result = await execute([first_path, second_path]).done
	
	var exit_code = result[0]
	var output = result[1]
	
	if exit_code != 0:
		var output_str = "\n".join(output)
		printerr("Exit code %d" % exit_code)
		printerr(output_str)
		if exit_code == -1:
			# Godot can't start process
			return ERR_CANT_FORK
		elif exit_code < 0:
			# C# exceptions have weirdly negative exit codes
			# Use the output to inspect deeper...
			if output_str.contains("The process cannot access the file") and output_str.contains("because it is being used by another process"):
				return ERR_ALREADY_IN_USE
		elif exit_code == 1:
			# No Chat Wheel config VPK.
			return ERR_FILE_UNRECOGNIZED
		return FAILED
	return OK


func execute(args: Array):
	var tp = ThreadedProcess.new()
	tp.execute(get_executable_path(), args, true, false)
	add_child(tp)
	return tp


func get_executable_path() -> String:
	if OS.has_feature("editor"):
		return "../CLI/bin/Release/net8.0/win-x64/publish/ChatLane.exe"
	else:
		return FS.get_installation_path().path_join("cli/ChatLane.exe")
