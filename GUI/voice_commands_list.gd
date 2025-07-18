extends Control


signal delete(index: int)
signal move(from: int, to: int)

const VoiceCommand = preload("res://voice_command.tscn")
const VOICE_LINES_LIMIT = 12


func _enter_tree() -> void:
	VoiceCommandsDB.add_voice_command.connect(_add_voice_command_by_id)


func _exit_tree() -> void:
	VoiceCommandsDB.add_voice_command.disconnect(_add_voice_command_by_id)


func _add_voice_command_by_id(id: String):
	add_voice_command(VoiceCommandsDB.find(id))


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	# TODO: preview drop position with a horizontal line
	return typeof(data) == TYPE_ARRAY and !data.is_empty()


func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data[0] == "list":
		VoiceCommandsDB.add_voice_command.emit(data[1].id)
	elif data[0] == "item":
		var old_index = data[1].get_index()
		var new_index = get_drop_index(at_position.y)
		if new_index >= 0 and old_index != new_index:
			if new_index > old_index:
				new_index -= 1
			%Items.move_child(data[1], new_index)
			move.emit(old_index, new_index)


func clear():
	while %Items.get_child_count() > 0:
		%Items.remove_child(%Items.get_child(0))
	update_voice_counter(0)


func add_voice_command(item: Dictionary):
	$EmptyState.hide()
	
	var vc = VoiceCommand.instantiate()
	vc.id = item["id"]
	vc.name = item["id"] # may be duplicate, but it's only for debugging so whatever
	vc.label = item["label"]
	vc.show_delete_button = true
	vc.delete.connect(_on_vc_delete.bind(item["id"]))
	vc.drag_context = "item"
	%Items.add_child(vc)
	update_voice_counter()
	update_items_error()


func get_drop_index(pos: float) -> int:
	var height = %Items.get_child(0).size.y + %Items.get_theme_constant("separation")
	pos += int(height / 2.0)
	return clamp(int(pos / height), 0, %Items.get_child_count())


func _on_vc_delete(vc_name: String):
	var vc
	for child in %Items.get_children():
		if child.id == vc_name:
			vc = child
			break
	if !vc: return
	var index = vc.get_index()
	var is_last = %Items.get_child_count() <= 1
	%Items.remove_child(vc)
	vc.queue_free()
	delete.emit(index)
	
	if is_last:
		$EmptyState.show()
	update_voice_counter()
	update_items_error()


func update_voice_counter(count := -1):
	if count < 0:
		count = %Items.get_child_count()
	$VoiceCounter.text = TranslationFluent.args("vc-count", {
		"count": count, "limit": VOICE_LINES_LIMIT
	})
	if count > VOICE_LINES_LIMIT:
		$VoiceCounter.add_theme_color_override("font_color", Color.RED)
		$VoiceCounter.add_theme_font_override("font", load("res://fonts/Montserrat-Bold.ttf"))
	else:
		$VoiceCounter.remove_theme_color_override("font_color")
		$VoiceCounter.remove_theme_font_override("font")


func update_items_error():
	var known_items = []
	var duplicate_items = []
	for item in %Items.get_children():
		var id = item.id
		if id in known_items and id not in duplicate_items:
			duplicate_items.append(id)
		elif id not in known_items:
			known_items.append(id)
	for item in %Items.get_children():
		var errors = PackedStringArray()
		var add_error = func(type):
			errors.append("- " + tr("vc-error-" + type))
		
		var id = item.id
		if VoiceCommandsDB.find(id)["isMenu"]:
			add_error.call("menu")
		
		if id in duplicate_items:
			add_error.call("duplicate")
		
		item.error_text = "\n".join(errors)


func rotate_ccw():
	var item = %Items.get_child(0)
	%Items.move_child(item, -1)


func rotate_cw():
	var item = %Items.get_child(-1)
	%Items.move_child(item, 0)
