extends Node

signal error(message: String)
signal loaded
signal unsaved_status_changed

var is_loading := false
var has_unsaved_changes := false:
	set(value):
		var old_value = has_unsaved_changes
		has_unsaved_changes = value
		if value != old_value:
			unsaved_status_changed.emit()

var config_name: String
var override_bindable: Dictionary
var custom_menus: Array


func _init() -> void:
	reset_cfg(false)


func reset_cfg(emit := true) -> void:
	config_name = "new_config"
	override_bindable = { "Missing": true }
	custom_menus = []

	if emit:
		is_loading = true
		loaded.emit()
		is_loading = false


func load_cfg(yaml: String) -> void:
	var data = YAML.parse(yaml)

	reset_cfg(false)

	if validate(type_string(typeof(data["name"])), type_string(TYPE_STRING), "name is not a string"):
		config_name = data["name"]

	if validate(type_string(typeof(data["override_bindable"])), type_string(TYPE_DICTIONARY), "override_bindable is not a dictionary") and \
		ensure(data["override_bindable"].keys().all(func(k): return typeof(k) == TYPE_STRING), "override_bindable has a non-string key") and \
		ensure(data["override_bindable"].values().all(func(v): return typeof(v) == TYPE_BOOL), "override_bindable has a non-bool value"):
		override_bindable = data["override_bindable"]

	# TODO: validate custom_menus dictionary schema
	if validate(type_string(typeof(data["custom_menus"])), type_string(TYPE_ARRAY), "custom_menus is not an array") and \
		ensure(data["custom_menus"].all(func(i): return typeof(i) == TYPE_DICTIONARY), "custom_menus has a non-dictionary item"):
		custom_menus = data["custom_menus"]
	
	is_loading = true
	loaded.emit()
	is_loading = false


func save_cfg() -> String:
	var data = {
		"name": config_name,
		"override_bindable": override_bindable,
		"custom_menus": custom_menus,
	}
	return YAML.to_string(data)


func validate(actual, expect, message: String) -> bool:
	if expect != actual:
		error.emit(
			tr(TranslationFluent.args("config-validation-error-template", {
				"message": message, "expect": str(expect), "actual": str(actual)
			}))
		)
		return false
	return true


func ensure(condition: bool, message: String) -> bool:
	if !condition:
		error.emit(message)
		return false
	return true
