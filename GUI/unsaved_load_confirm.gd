extends ConfirmationDialog

signal discard_changes

func _ready():
	add_button("dialog-unsaved-load-continue", true, "continue")
	custom_action.connect(func(action):
		if action == "continue":
			discard_changes.emit()
	)
