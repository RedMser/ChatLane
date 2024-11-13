extends ConfirmationDialog


func _ready():
	add_button("dialog-unsaved-exit-quit", true, "quit")
	custom_action.connect(func(action):
		if action == "quit":
			get_tree().quit()
	)
