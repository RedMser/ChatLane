extends Node


const language_file = "user://language"
var languages := []
const language_names := {}
var language_flags := {}
const NO_ICON = preload("res://no_icon.png")


func _ready() -> void:
	const i18n_path = "res://i18n/"
	
	languages = Array(DirAccess.get_files_at(i18n_path)).\
		filter(func(filename): return filename.to_lower().get_extension() == "ftl").\
		map(func(filename): return filename.get_basename())
	
	# ensure english is first
	languages.erase("en")
	languages.push_front("en")
	
	for language in languages:
		# load i18n
		var path = i18n_path.path_join(language + ".ftl")
		var translation = load(path)
		TranslationServer.add_translation(translation)
		
		# load flag
		var flag_path = "res:///flags/" + language + ".png"
		var flag
		if ResourceLoader.exists(flag_path):
			flag = load(flag_path)
		else:
			flag = NO_ICON
		language_flags[language] = flag
	
	var language = FileAccess.open(language_file, FileAccess.READ)
	if language == null:
		language = FileAccess.open(language_file, FileAccess.WRITE)
		
		var default_locale = OS.get_locale_language()
		language.store_string(default_locale)
		TranslationServer.set_locale(default_locale)
	else:
		var locale = language.get_as_text()
		TranslationServer.set_locale(locale)

func get_language_name(language: String) -> String:
	if language in language_names:
		return language_names[language]
	return TranslationServer.get_language_name(language)
