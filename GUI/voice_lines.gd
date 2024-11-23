extends VBoxContainer


func _ready() -> void:
	const VoiceCommand = preload("res://voice_command.tscn")
	const VoiceCommandSection = preload("res://voice_command_section.tscn")
	
	var vcl = VoiceCommandsDB.grouped_by_categories()
	
	for category_name in vcl.keys():
		var vcs = VoiceCommandSection.instantiate()
		vcs.text = "vc-category-%s" % category_name
		vcs.help_text = VoiceCommandsDB.category_get_help_text(category_name)
		add_child(vcs)
		
		for item in vcl[category_name]:
			var vc = VoiceCommand.instantiate()
			vc.id = item["id"]
			vc.name = item["id"] # might be invalid, but it's for debugging only, so whatever
			vc.show_enabled_checkbox = item["canDisable"]
			vc.label = item["label"]
			add_child(vc)
