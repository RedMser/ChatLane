extends VBoxContainer


signal updated
signal delete

const VoiceCommand = preload("res://voice_command.gd")


var custom_menu_index := -1:
	set(value):
		custom_menu_index = value
		update_custom_menu()

var custom_menu: Dictionary:
	get:
		return Config.custom_menus[custom_menu_index]


func _ready() -> void:
	%Icons.add_item("placeholder-no-icon", IconDB.NO_ICON)
	%Icons.set_item_icon_modulate(%Icons.item_count-1, IconDB.DARK_COLOR)
	for id in IconDB.ICON_LIST.keys():
		var icon = IconDB.ICON_LIST[id]
		%Icons.add_item("icon-" + id, icon)
		%Icons.set_item_icon_modulate(%Icons.item_count-1, IconDB.DARK_COLOR)


func _enter_tree() -> void:
	VoiceCommandsDB.add_voice_command.connect(_on_voice_commands_list_add)


func _exit_tree() -> void:
	VoiceCommandsDB.add_voice_command.disconnect(_on_voice_commands_list_add)


func update_custom_menu():
	if custom_menu_index < 0:
		hide()
		return
	show()
	
	%Name.text = custom_menu["name"]
	
	%Icons.deselect_all()
	if custom_menu["icon"]:
		# TODO: shouldn't rely on order of dicts to stay same in future
		var i = IconDB.ICON_LIST.keys().find(custom_menu["icon"])
		if i >= 0:
			%Icons.select(i+1)
	else:
		%Icons.select(0)

	%VoiceCommandsList.clear()
	for item in custom_menu["items"]:
		var found = VoiceCommandsDB.find(item)
		if found:
			%VoiceCommandsList.add_voice_command(found)
		else:
			push_error("Unknown voice command ", item)
	update_preview()


func _on_name_text_changed(new_text: String) -> void:
	if new_text.is_empty():
		new_text = tr("placeholder-unnamed")
	custom_menu["name"] = new_text
	updated.emit()
	Config.has_unsaved_changes = true


func _on_icons_item_selected(index: int) -> void:
	if index <= 0:
		custom_menu["icon"] = null
	else:
		# TODO: shouldn't rely on order of dicts to stay same in future -> use item metadata
		custom_menu["icon"] = IconDB.ICON_LIST.keys()[index-1]
	updated.emit()
	Config.has_unsaved_changes = true


func _on_confirmation_dialog_confirmed() -> void:
	delete.emit()
	Config.has_unsaved_changes = true


func _on_voice_commands_list_add(id: String) -> void:
	if custom_menu_index < 0: return
	custom_menu["items"].append(id)
	update_preview()
	Config.has_unsaved_changes = true


func _on_voice_commands_list_move(from: int, to: int) -> void:
	var item = custom_menu["items"].pop_at(from)
	custom_menu["items"].insert(to, item)
	update_preview()
	Config.has_unsaved_changes = true


func _on_voice_commands_list_delete(index: int) -> void:
	custom_menu["items"].remove_at(index)
	update_preview()
	Config.has_unsaved_changes = true


func update_preview():
	var arr: Array[String] = []
	for id in custom_menu["items"]:
		var item = VoiceCommandsDB.find(id)
		var label = id
		if !item.is_empty():
			label = item["label"]
		# Gain some space
		label = tr(label).replace(" ", "\n")
		arr.append(label)
	%Preview.entries = arr


func _on_rotate_ccw_pressed() -> void:
	if custom_menu["items"].is_empty(): return
	var item = custom_menu["items"].pop_front()
	custom_menu["items"].push_back(item)
	%VoiceCommandsList.rotate_ccw()
	update_preview()
	Config.has_unsaved_changes = true


func _on_rotate_cw_pressed() -> void:
	if custom_menu["items"].is_empty(): return
	var item = custom_menu["items"].pop_back()
	custom_menu["items"].push_front(item)
	%VoiceCommandsList.rotate_cw()
	update_preview()
	Config.has_unsaved_changes = true
