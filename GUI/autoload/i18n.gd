extends Node


func _ready() -> void:
	const i18n_path = "res://i18n/"
	for filename in DirAccess.get_files_at(i18n_path):
		if filename.to_lower().get_extension() != "ftl": continue
		var path = i18n_path.path_join(filename)
		var translation = load(path)
		TranslationServer.add_translation(translation)
