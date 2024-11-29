@tool
extends PanelContainer

signal delete

@export var id := ""
## Only for display purposes. Defaults to [member id] if unspecified.
@export var label := "":
	set(value):
		label = value
		if is_node_ready():
			update_display_text()
@export var show_enabled_checkbox := false:
	set(value):
		show_enabled_checkbox = value
		if is_node_ready():
			$HBoxContainer/Bindable.visible = value
			$HBoxContainer/PingWheelBindable.visible = value
@export var is_bindable := false:
	set(value):
		is_bindable = value
		if is_node_ready():
			$HBoxContainer/Bindable.button_pressed = value
@export var is_ping_wheel_bindable := false:
	set(value):
		is_ping_wheel_bindable = value
		if is_node_ready():
			$HBoxContainer/PingWheelBindable.button_pressed = value
@export var show_delete_button := false:
	set(value):
		show_delete_button = value
		if is_node_ready():
			$HBoxContainer/Delete.visible = value
var error_text := "":
	set(value):
		error_text = value
		if is_node_ready():
			update_error_text()
var drag_context := "list"
var default_stylebox: StyleBoxFlat
var error_stylebox: StyleBoxFlat


func _ready():
	default_stylebox = get("theme_override_styles/panel")
	error_stylebox = default_stylebox.duplicate()
	error_stylebox.bg_color = Color(0.633, 0.33, 0.39)
	
	update_display_text()
	show_enabled_checkbox = show_enabled_checkbox
	is_bindable = is_bindable
	is_ping_wheel_bindable = is_ping_wheel_bindable
	show_delete_button = show_delete_button
	update_error_text()


func update_display_text():
	var display_text = label
	if label.is_empty():
		display_text = id
	$HBoxContainer/Label.text = display_text


func update_error_text():
	tooltip_text = error_text
	if error_text.is_empty():
		add_theme_stylebox_override("panel", default_stylebox)
		$HBoxContainer/Label.remove_theme_color_override("font_color")
	else:
		add_theme_stylebox_override("panel", error_stylebox)
		$HBoxContainer/Label.add_theme_color_override("font_color", Color.WHITE)


func _get_drag_data(at_position: Vector2) -> Variant:
	var preview = load("res://voice_command.tscn").instantiate()
	preview.id = id
	preview.label = label
	preview.error_text = error_text
	set_drag_preview(preview)
	return [drag_context, self]


func _on_delete_pressed() -> void:
	delete.emit()
	Config.has_unsaved_changes = true


func _on_bindable_toggled(toggled_on: bool) -> void:
	if !show_enabled_checkbox:
		return
	if Engine.is_editor_hint():
		return
	if Config.is_loading or not get_tree().current_scene.is_node_ready():
		# only user interaction should be tracked, not _ready or config load
		return
	var default = VoiceCommandsDB.find(id)["bindable"]
	if toggled_on == default:
		Config.override_bindable.erase(id)
	else:
		Config.override_bindable[id] = toggled_on
	Config.has_unsaved_changes = true


func _on_ping_wheel_bindable_toggled(toggled_on: bool) -> void:
	if !show_enabled_checkbox:
		return
	if Engine.is_editor_hint():
		return
	if Config.is_loading or not get_tree().current_scene.is_node_ready():
		# only user interaction should be tracked, not _ready or config load
		return
	var default = VoiceCommandsDB.find(id)["pingWheelBindable"]
	if toggled_on == default:
		Config.override_ping_wheel_bindable.erase(id)
	else:
		Config.override_ping_wheel_bindable[id] = toggled_on
	Config.has_unsaved_changes = true


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and event.double_click:
		VoiceCommandsDB.add_voice_command.emit(id)
