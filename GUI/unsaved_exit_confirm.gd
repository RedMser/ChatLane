extends ConfirmationDialog


func _ready():
	add_button("Quit without saving", true, "quit")
	custom_action.connect(func(action):
		if action == "quit":
			get_tree().quit()
	)
