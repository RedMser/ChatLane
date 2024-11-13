@tool
extends PanelContainer

@export var text := "Title":
	set(value):
		text = value
		if is_node_ready():
			$Label.text = value

@export_multiline var help_text := "":
	set(value):
		help_text = value
		if is_node_ready():
			$HBoxContainer.visible = !value.is_empty()
			$HBoxContainer/HelpButton/HelpDialog.dialog_text = value


func _ready():
	text = text
	help_text = help_text
