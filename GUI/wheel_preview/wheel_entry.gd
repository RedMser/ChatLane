@tool
extends Control

@export_multiline var text: String
@export var base_color: Color
@export var radius_multiplier: float = 1.0
@export var button_size: float
@export var entries: int = 1
@export var is_active := false


signal pressed


func _ready() -> void:
	set_process(Engine.is_editor_hint())
	update()


func _process(delta: float) -> void:
	update()


func update() -> void:
	visible = !text.is_empty()
	
	%Radial.tint_progress = base_color.inverted() if is_active else base_color
	%Radial.scale = Vector2.ONE * radius_multiplier
	%Radial.position = Vector2(-512.0, -512.0) * radius_multiplier
	%Radial.max_value = entries
	%Radial.value = 0.9
	
	%ButtonDolly.rotation = -get_global_transform().get_rotation()
	
	%Button.size = Vector2.ONE * button_size
	%Button.size.x = 1024.0 / max(1.0, float(entries - 1)) * 2.0
	%Button.position = -%Button.size / 2.0
	%Button.pivot_offset = %Button.size / 2.0
	%Button.rotation = get_global_transform().get_rotation()
	
	%ButtonLabel.add_theme_font_size_override("font_size", 14.0 / radius_multiplier)
	%ButtonLabel.add_theme_color_override("font_color", Color.BLACK if is_active else Color.WHITE)
	%ButtonLabel.text = text
	%ButtonLabel.size.x = %Button.size.x
	%ButtonLabel.size.y = 0.0
	%ButtonLabel.pivot_offset = %ButtonLabel.size / 2.0
	%ButtonLabel.position = -%ButtonLabel.size / 2.0


func _on_button_pressed() -> void:
	pressed.emit()
