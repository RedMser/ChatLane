extends PanelContainer


signal add(id: String)
signal delete(index: int)
signal move(from: int, to: int)

const VoiceCommand = preload("res://voice_command.tscn")
const VOICE_LINES_LIMIT = 12


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	# TODO: preview drop position with a horizontal line
	return typeof(data) == TYPE_ARRAY and !data.is_empty()


func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data[0] == "list":
		add_voice_command(data[1].name, data[1].label)
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


func add_voice_command(node_name: StringName, label: String, emit := true):
	$EmptyState.hide()
	
	var vc = VoiceCommand.instantiate()
	while %Items.has_node(str(node_name)):
		node_name += "$" # keep node names unique
	vc.name = node_name
	vc.label = label
	vc.show_delete_button = true
	vc.delete.connect(_on_vc_delete.bind(str(vc.name)))
	vc.drag_context = "item"
	%Items.add_child(vc)
	if emit:
		add.emit(vc.get_id())
	update_voice_counter()


func get_drop_index(pos: float) -> int:
	var height = %Items.get_child(0).size.y + %Items.get_theme_constant("separation")
	pos += int(height / 2.0)
	return clamp(int(pos / height), 0, %Items.get_child_count())


func _on_vc_delete(vc_name: String):
	var vc = %Items.get_node_or_null(vc_name)
	if !vc: return
	var index = vc.get_index()
	var is_last = %Items.get_child_count() <= 1
	%Items.remove_child(vc)
	vc.queue_free()
	delete.emit(index)
	
	if is_last:
		$EmptyState.show()
	update_voice_counter()


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
