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

	while %Items.get_child_count() > 0:
		%Items.remove_child(%Items.get_child(0))
	for item in custom_menu["items"]:
		var vcs = $/root/VBoxContainer/%VoiceLines.get_children()
		var found
		for vc in vcs:
			if vc is VoiceCommand and vc.get_id() == item:
				found = vc
				break
		if found:
			$VoiceCommandsList.add_voice_command(found.name, found.label, false)
		else:
			push_error("Unknown voice command ", item)


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
	custom_menu["items"].append(id)
	Config.has_unsaved_changes = true


func _on_voice_commands_list_move(from: int, to: int) -> void:
	var item = custom_menu["items"].pop_at(from)
	custom_menu["items"].insert(to, item)
	Config.has_unsaved_changes = true


func _on_voice_commands_list_delete(index: int) -> void:
	custom_menu["items"].remove_at(index)
	Config.has_unsaved_changes = true
