extends MarginContainer


func _ready() -> void:
	# update locale list
	var current_locale = TranslationServer.get_locale()
	for locale in I18n.languages:
		%Languages.add_item(I18n.get_language_name(locale), I18n.language_flags[locale])
		var idx = %Languages.item_count-1
		%Languages.set_item_metadata(idx, locale)
		if current_locale.begins_with(locale):
			%Languages.select(idx)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()


func _on_confirm_pressed() -> void:
	get_tree().change_scene_to_file("res://root.tscn")


func _on_languages_item_activated(index: int) -> void:
	get_tree().change_scene_to_file("res://root.tscn")


func _on_languages_item_selected(index: int) -> void:
	TranslationServer.set_locale(%Languages.get_item_metadata(index))
