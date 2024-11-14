@tool
extends PanelContainer

signal delete

## Only for display purposes. Defaults to node's name if unspecified.
@export var label := "":
	set(value):
		label = value
		if is_node_ready():
			update_display_text()
@export var show_enabled_checkbox := false:
	set(value):
		show_enabled_checkbox = value
		if is_node_ready():
			$HBoxContainer/Enabled.visible = value
@export var is_enabled := false:
	set(value):
		is_enabled = value
		if is_node_ready():
			$HBoxContainer/Enabled.button_pressed = value
@export var show_delete_button := false:
	set(value):
		show_delete_button = value
		if is_node_ready():
			$HBoxContainer/Delete.visible = value
var drag_context := "list"


func _ready():
	update_display_text()
	show_enabled_checkbox = show_enabled_checkbox
	is_enabled = is_enabled
	show_delete_button = show_delete_button


func update_display_text():
	var display_text = label
	if label.is_empty():
		display_text = str(name).replace("$", "")
	$HBoxContainer/Label.text = display_text


func get_id() -> String:
	return str(name).replace("$SLASH$", "/").replace("$", "")


func _get_drag_data(at_position: Vector2) -> Variant:
	var preview = load("res://voice_command.tscn").instantiate()
	preview.name = name
	preview.label = label
	set_drag_preview(preview)
	return [drag_context, self]


func _on_delete_pressed() -> void:
	delete.emit()
	Config.has_unsaved_changes = true


func _on_enabled_toggled(toggled_on: bool) -> void:
	if !show_enabled_checkbox:
		return
	if Engine.is_editor_hint():
		return
	# makes little sense to write a "false" to bindable explicitly
	if toggled_on:
		Config.override_bindable[get_id()] = toggled_on
	else:
		Config.override_bindable.erase(get_id())
	Config.has_unsaved_changes = true
