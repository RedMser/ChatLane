extends VBoxContainer


var after_unsaved_action


func _init() -> void:
	Config.error.connect(func(msg): alert(TranslationFluent.args("config-load-error-template", { "cause": msg })))
	Config.loaded.connect(_on_config_loaded)
	Config.unsaved_status_changed.connect(func():
		var normalized_title = get_tree().root.title.replace("*", "");
		if Config.has_unsaved_changes:
			normalized_title = "*" + normalized_title
		get_tree().root.title = normalized_title
	)


func _ready() -> void:
	Config.is_loading = true
	_on_config_loaded()
	Config.is_loading = false
	
	%LanguageChange.icon = I18n.language_flags[TranslationServer.get_locale()]
	var lang_menu: PopupMenu = %LanguageChange.get_popup()
	lang_menu.add_theme_constant_override("icon_max_width", 40)
	for language in I18n.languages:
		lang_menu.add_icon_item(I18n.language_flags[language], I18n.get_language_name(language))
	lang_menu.index_pressed.connect(func(idx):
		var language = I18n.languages[idx]
		TranslationServer.set_locale(language)
		%LanguageChange.icon = I18n.language_flags[language]
		var language_file = FileAccess.open(I18n.language_file, FileAccess.WRITE)
		language_file.store_string(language)
	)
	var make_shortcut = func(action):
		var s = Shortcut.new()
		var e = InputEventAction.new()
		e.action = action
		e.pressed = true
		s.events.append(e)
		return s
	$"MenuBar/menu-file".set_item_shortcut(0, make_shortcut.call("file-new"))
	$"MenuBar/menu-file".set_item_shortcut(2, make_shortcut.call("file-open"))
	$"MenuBar/menu-file".set_item_shortcut(4, make_shortcut.call("file-save"))
	$"MenuBar/menu-help".set_item_shortcut(0, make_shortcut.call("help-repo"))


func _enter_tree() -> void:
	RootWindow.files_dropped.connect(_on_files_dropped)


func _exit_tree() -> void:
	RootWindow.files_dropped.disconnect(_on_files_dropped)


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
		recover_last_save_folder()
		$LoadDialog.popup_centered()


func save_cfg():
	if Config.config_name == Config.DEFAULT_CONFIG_NAME:
		$SaveDialog.current_file = "pak50_dir.vpk"
	elif Config.config_name.begins_with("pak") and Config.config_name.ends_with("_dir"):
		$SaveDialog.current_file = Config.config_name + ".vpk"
	else:
		$SaveDialog.current_file = Config.config_name + ".yml"
	
	recover_last_save_folder()
	$SaveDialog.popup_centered()


func locate_vpk_addon():
	recover_last_save_folder()
	$LocateDialog.popup_centered()


func _on_locate_dialog_dir_selected(dir: String) -> void:
	store_last_save_folder($LocateDialog.current_dir)
	
	var vpks = Array(DirAccess.get_files_at(dir)).filter(func(file):
		file = file.to_lower()
		return file.ends_with("_dir.vpk") and file.begins_with("pak") and file != "pak01_dir.vpk"
	)
	
	if vpks.is_empty():
		alert("alert-locate-no-vpks")
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
	
	alert(TranslationFluent.args("alert-locate-results", {
		"count": float(succeeded.size()), "vpks": ", ".join(PackedStringArray(succeeded))
	}))


func _on_load_dialog_file_selected(path: String) -> void:
	$Spinner.set_visible_soon(true)
	
	store_last_save_folder($LoadDialog.current_dir)
	
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
		alert("alert-invalid-file-extension")
	$Spinner.set_visible_soon(false)


func _on_save_dialog_file_selected(path: String) -> void:
	$Spinner.set_visible_soon(true)
	
	store_last_save_folder($SaveDialog.current_dir)
	
	Config.config_name = path.get_file().get_basename()
	%ConfigName.text = Config.config_name

	var ext = path.to_lower().get_extension()
	var yaml = Config.save_cfg()
	if ext == "vpk":
		var temp = FS.get_temp_file_access("input.yml", true)
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
		alert("alert-invalid-file-extension")
	$Spinner.set_visible_soon(false)


func recover_last_save_folder():
	var last_save_folder
	if FileAccess.file_exists("user://last_save_folder"):
		last_save_folder = FileAccess.get_file_as_string("user://last_save_folder")
	else:
		var f = FileAccess.open("user://last_save_folder", FileAccess.WRITE)
		last_save_folder = await Steam.find_deadlock_installation()
		if !last_save_folder.is_empty():
			# Select the addons folder (create if does not exist)
			last_save_folder = last_save_folder.path_join("game/citadel/addons")
			if !DirAccess.dir_exists_absolute(last_save_folder):
				DirAccess.make_dir_recursive_absolute(last_save_folder)
		f.store_string(last_save_folder)
		f.close()
	
	if DirAccess.dir_exists_absolute(last_save_folder):
		$SaveDialog.current_dir = last_save_folder
		$LoadDialog.current_dir = last_save_folder
		$LocateDialog.current_dir = last_save_folder


func store_last_save_folder(path: String):
	var f = FileAccess.open("user://last_save_folder", FileAccess.WRITE)
	f.store_string(path)
	f.close()


func alert(text: String):
	$AlertDialog.dialog_text = text
	$AlertDialog.popup_centered()


func _on_reset_to_default_confirm_confirmed() -> void:
	Config.reset_cfg()
	Config.has_unsaved_changes = false


func _on_config_loaded() -> void:
	if not is_node_ready():
		return
	
	%ConfigName.text = Config.config_name
	
	const VoiceCommand = preload("res://voice_command.gd")
	for child in %VoiceLines.get_children():
		if !(child is VoiceCommand):
			continue
		child.is_bindable = Config.override_bindable.get(child.id, VoiceCommandsDB.find(child.id)["bindable"])
		child.is_ping_wheel_bindable = Config.override_ping_wheel_bindable.get(child.id, VoiceCommandsDB.find(child.id)["pingWheelBindable"])

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
	if !FileAccess.file_exists("user://custom_menu_warning_seen") or OS.has_feature("editor"):
		FileAccess.open("user://custom_menu_warning_seen", FileAccess.WRITE).close()
		%CustomMenuLimitWarning.popup()
	
	var menu := {
		"name": tr("cm-default-name"),
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
	%CustomMenus.add_item(Utils.limit_string(menu.name, 32), IconDB.get_texture(menu.icon))
	%CustomMenus.set_item_icon_modulate(%CustomMenus.item_count-1, IconDB.DARK_COLOR)


func _on_custom_menu_editor_updated() -> void:
	var selected = %CustomMenus.get_selected_items()
	if selected.is_empty():
		return
	selected = selected[0]
	var menu = Config.custom_menus[selected]
	%CustomMenus.set_item_text(selected, Utils.limit_string(menu["name"], 32))
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
			alert("error-cli-cant-fork")
		ERR_ALREADY_IN_USE:
			alert("error-cli-already-in-use")
		ERR_FILE_UNRECOGNIZED:
			alert("error-cli-file-unrecognized")
		_:
			alert("error-cli-generic")
	return false


func _on_unsaved_confirm_confirmed(_after_unsaved_action) -> void:
	after_unsaved_action = _after_unsaved_action
	save_cfg()


func _on_unsaved_load_confirm_discard_changes() -> void:
	$UnsavedLoadConfirm.hide()
	recover_last_save_folder()
	$LoadDialog.popup_centered()


func handle_after_unsaved_action():
	Config.has_unsaved_changes = false
	match after_unsaved_action:
		"exit":
			get_tree().quit()
		"load":
			load_cfg()
		"file-drop":
			_on_file_dropped($UnsavedFileDropConfirm.get_meta("file"))
	after_unsaved_action = null


func _on_edit_vc_list_toggled(toggled_on: bool) -> void:
	for vc in %VoiceLines.get_children():
		const VoiceCommand = preload("res://voice_command.gd")
		if !(vc is VoiceCommand):
			continue
		vc.show_enabled_checkbox = toggled_on


func _on_files_dropped(files: PackedStringArray) -> void:
	if files.is_empty():
		return
	elif files.size() > 1:
		alert("alert-files-dropped-multiple")
		return
	var file = files[0]
	if Config.has_unsaved_changes:
		$UnsavedFileDropConfirm.set_meta("file", file)
		$UnsavedFileDropConfirm.popup_centered()
	else:
		_on_file_dropped(file)


func _on_file_dropped(file: String) -> void:
	# Remember path of file.
	$LoadDialog.current_dir = file.get_base_dir()
	_on_load_dialog_file_selected(file)


func _on_unsaved_file_drop_confirm_discard_changes() -> void:
	$UnsavedFileDropConfirm.hide()
	_on_file_dropped($UnsavedFileDropConfirm.get_meta("file"))
