extends VBoxContainer


var after_unsaved_action


func _init() -> void:
	randomize()
	Config.error.connect(func(msg): alert("Loading config failed: %s" % msg))
	Config.loaded.connect(_on_config_loaded)
	Config.unsaved_status_changed.connect(func():
		var normalized_title = get_tree().root.title.replace("*", "");
		if Config.has_unsaved_changes:
			normalized_title = "*" + normalized_title
		get_tree().root.title = normalized_title
	)


func _ready() -> void:
	_on_config_loaded()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if Config.has_unsaved_changes:
			$UnsavedExitConfirm.popup_centered()
		else:
			get_tree().quit()


func _on_file_id_pressed(id: int) -> void:
	match id:
		1:
			reset_to_default_config()
		2:
			load_cfg()
		3:
			save_cfg()
		4:
			notification(NOTIFICATION_WM_CLOSE_REQUEST)
		5:
			locate_vpk_addon()


func _on_help_id_pressed(id: int) -> void:
	match id:
		1:
			OS.shell_open("https://github.com/redmser/chatlane")
		2:
			$AboutDialog.popup_centered()


func reset_to_default_config():
	if Config.has_unsaved_changes:
		$ResetToDefaultConfirm.popup_centered()
	else:
		Config.reset_cfg()


func load_cfg():
	if Config.has_unsaved_changes:
		$UnsavedLoadConfirm.popup_centered()
	else:
		$LoadDialog.popup_centered()


func save_cfg():
	$SaveDialog.popup_centered()


func locate_vpk_addon():
	$LocateDialog.popup_centered()


func _on_locate_dialog_dir_selected(dir: String) -> void:
	var vpks = Array(DirAccess.get_files_at(dir)).filter(func(file):
		file = file.to_lower()
		return file.ends_with("_dir.vpk") and file.begins_with("pak") and file != "pak01_dir.vpk"
	)
	
	if vpks.is_empty():
		alert("The folder you selected does not seem to contain any add-on VPK files.\nTry a folder like steamapps/common/Deadlock/game/citadel/addons")
		return
	
	$Spinner.set_visible_soon(true)
	var succeeded = []
	for vpk in vpks:
		var success = await CLI.conversion(dir.path_join(vpk), "dummy")
		if success == ERR_FILE_UNRECOGNIZED:
			# Silently ignore this error, since it's expected
			continue
		elif handle_cli_success(success):
			succeeded.append(vpk)
	$Spinner.set_visible_soon(false)
	
	if succeeded.size() == 1:
		alert("%s contains your Chat Wheel config." % succeeded[0])
	elif succeeded.is_empty():
		alert("None of the add-on VPKs in the selected folder contain Chat Wheel configs.")
	else:
		alert("Following %d VPKs contain Chat Wheel configs:\n%s" % [succeeded.size(), ", ".join(PackedStringArray(succeeded))])


func _on_load_dialog_file_selected(path: String) -> void:
	$Spinner.set_visible_soon(true)
	var ext = path.to_lower().get_extension()
	if ext == "vpk":
		var temp_path = FS.get_temp_file_path("result.yml")
		var success = await CLI.conversion(path, temp_path)
		if handle_cli_success(success):
			Config.load_cfg(FileAccess.get_file_as_string(temp_path))
			Config.has_unsaved_changes = false
		DirAccess.remove_absolute(temp_path)
	elif ext == "yml" or ext == "yaml":
		Config.load_cfg(FileAccess.get_file_as_string(path))
		Config.has_unsaved_changes = false
	else:
		alert("File does not have a valid file extension!")
	$Spinner.set_visible_soon(false)


func _on_save_dialog_file_selected(path: String) -> void:
	$Spinner.set_visible_soon(true)
	
	Config.config_name = path.get_file().get_basename()
	$MenuBar/ConfigName.text = Config.config_name

	var ext = path.to_lower().get_extension()
	var yaml = Config.save_cfg()
	if ext == "vpk":
		var temp = FS.get_temp_file_access("input.yml")
		var temp_path = temp.get_path_absolute()
		temp.store_string(yaml)
		temp.close()
		var success = await CLI.conversion(temp_path, path)
		if handle_cli_success(success):
			handle_after_unsaved_action()
		DirAccess.remove_absolute(temp_path)
	elif ext == "yml" or ext == "yaml":
		var fa = FileAccess.open(path, FileAccess.WRITE)
		fa.store_string(yaml)
		handle_after_unsaved_action()
	else:
		alert("File does not have a valid file extension!")
	$Spinner.set_visible_soon(false)


func alert(text: String):
	$AlertDialog.dialog_text = text
	$AlertDialog.popup_centered()


func _on_reset_to_default_confirm_confirmed() -> void:
	Config.reset_cfg()
	Config.has_unsaved_changes = false


func _on_config_loaded() -> void:
	if not is_node_ready():
		return
	
	$MenuBar/ConfigName.text = Config.config_name
	
	const VoiceCommand = preload("res://voice_command.gd")
	for child in %VoiceLines.get_children():
		if !(child is VoiceCommand) or !child.show_enabled_checkbox:
			continue
		child.is_enabled = Config.override_bindable.get(child.get_id(), false)

	%CustomMenus.clear()
	for menu in Config.custom_menus:
		create_custom_menu_item(menu)
	%CustomMenus.deselect_all()
	update_custom_menu_editor()


func update_custom_menu_editor():
	var selected = %CustomMenus.get_selected_items()
	if selected.is_empty():
		%CustomMenuEditor.custom_menu_index = -1
	else:
		selected = selected[0] # single select mode
		%CustomMenuEditor.custom_menu_index = selected


func _on_add_custom_menu_pressed() -> void:
	var menu := {
		"name": "New Custom Menu",
		"icon": null,
		"items": [],
	}
	Config.custom_menus.append(menu)
	create_custom_menu_item(menu)
	%CustomMenus.deselect_all()
	%CustomMenus.select(%CustomMenus.item_count - 1)
	update_custom_menu_editor()
	Config.has_unsaved_changes = true


func create_custom_menu_item(menu: Dictionary):
	%CustomMenus.add_item(menu.name, IconDB.get_texture(menu.icon))
	%CustomMenus.set_item_icon_modulate(%CustomMenus.item_count-1, IconDB.DARK_COLOR)


func _on_custom_menu_editor_updated() -> void:
	var selected = %CustomMenus.get_selected_items()
	if selected.is_empty():
		return
	selected = selected[0]
	var menu = Config.custom_menus[selected]
	%CustomMenus.set_item_text(selected, menu["name"])
	%CustomMenus.set_item_icon(selected, IconDB.get_texture(menu["icon"]))


func _on_custom_menu_editor_delete() -> void:
	var selected = %CustomMenus.get_selected_items()
	if selected.is_empty():
		return
	selected = selected[0]
	Config.custom_menus.remove_at(selected)
	%CustomMenus.remove_item(selected)
	%CustomMenus.deselect_all()
	update_custom_menu_editor()


func handle_cli_success(value: int) -> bool:
	match value:
		OK:
			return true
		ERR_CANT_FORK:
			alert("Unable to launch CLI app.\nMake sure you've extracted the zip archive of ChatLane,\nand did not rename, move or delete any files.")
		ERR_ALREADY_IN_USE:
			alert("Unable to access the selected file.\nMake sure you've closed any applications that might be using this file,\nsuch as Deadlock or Source2Viewer.")
		ERR_FILE_UNRECOGNIZED:
			alert("The selected VPK file does not contain Chat Wheel config.\nYou can try the \"File -> Locate add-on VPKs...\" option to find the correct VPK.")
		_:
			alert("Unable to run the CLI tool.\nCheck the console for more details, and report this as an issue on GitHub.")
	return false


func _on_unsaved_confirm_confirmed(_after_unsaved_action) -> void:
	after_unsaved_action = _after_unsaved_action
	save_cfg()


func _on_unsaved_load_confirm_discard_changes() -> void:
	$UnsavedLoadConfirm.hide()
	$LoadDialog.popup_centered()


func handle_after_unsaved_action():
	Config.has_unsaved_changes = false
	match after_unsaved_action:
		"exit":
			get_tree().quit()
		"load":
			load_cfg()
	after_unsaved_action = null
