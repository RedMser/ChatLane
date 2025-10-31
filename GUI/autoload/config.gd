extends Node

signal error(message: String)
signal loaded
signal unsaved_status_changed

const DEFAULT_CONFIG_NAME = "new_config"

var is_loading := false
var has_unsaved_changes := false:
	set(value):
		var old_value = has_unsaved_changes
		has_unsaved_changes = value
		if value != old_value:
			unsaved_status_changed.emit()

var config_name: String
var override_bindable: Dictionary
var override_ping_wheel_bindable: Dictionary
var custom_menus: Array


func _init() -> void:
	reset_cfg(false)


func reset_cfg(emit := true) -> void:
	config_name = DEFAULT_CONFIG_NAME
	override_bindable = {}
	override_ping_wheel_bindable = {}
	custom_menus = []

	if emit:
		is_loading = true
		loaded.emit()
		is_loading = false


func load_cfg(yaml: String) -> void:
	print("Load Config ", config_name, ":\n", yaml)
	var data = YAML.parse(yaml)

	reset_cfg(false)

	if validate(type_string(typeof(data.get("name"))), type_string(TYPE_STRING), "name is not a string"):
		config_name = data["name"]

	if validate(type_string(typeof(data.get("override_bindable"))), type_string(TYPE_DICTIONARY), "override_bindable is not a dictionary") and \
		ensure(data["override_bindable"].keys().all(func(k): return typeof(k) == TYPE_STRING), "override_bindable has a non-string key") and \
		ensure(data["override_bindable"].values().all(func(v): return typeof(v) == TYPE_BOOL), "override_bindable has a non-bool value"):
		override_bindable = data["override_bindable"]

	# default to {} since it is a new config field, backwards compat!
	var temp = data.get("override_ping_wheel_bindable", {})
	if validate(type_string(typeof(temp)), type_string(TYPE_DICTIONARY), "override_ping_wheel_bindable is not a dictionary") and \
		ensure(temp.keys().all(func(k): return typeof(k) == TYPE_STRING), "override_ping_wheel_bindable has a non-string key") and \
		ensure(temp.values().all(func(v): return typeof(v) == TYPE_BOOL), "override_ping_wheel_bindable has a non-bool value"):
		override_ping_wheel_bindable = temp

	# TODO: validate custom_menus dictionary schema
	if validate(type_string(typeof(data.get("custom_menus"))), type_string(TYPE_ARRAY), "custom_menus is not an array") and \
		ensure(data["custom_menus"].all(func(i): return typeof(i) == TYPE_DICTIONARY), "custom_menus has a non-dictionary item"):
		custom_menus = data["custom_menus"]
	
	# migrate old voice command ids
	for menu in custom_menus:
		for i in menu["items"].size():
			if menu["items"][i] == "You\\'re Welcome":
				menu["items"][i] = "You're Welcome"
			elif menu["items"][i] == "I\\'ll Clear Troopers":
				menu["items"][i] = "I'll Clear Troopers"
	
	is_loading = true
	loaded.emit()
	is_loading = false


func save_cfg() -> String:
	var data = {
		"name": config_name,
		"override_bindable": override_bindable,
		"override_ping_wheel_bindable": override_ping_wheel_bindable,
		"custom_menus": custom_menus,
	}
	var yaml = YAML.to_string(data)
	print("Save Config ", config_name, ":\n", yaml)
	return yaml


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
