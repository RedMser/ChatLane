extends Node


const DARK_COLOR = Color(0.049, 0.039, 0.026)

const ICON_LIST := {
	"defend": preload("res://ping_icons/ping_icon_defend.svg"),
	"going_in": preload("res://ping_icons/ping_icon_going_in.svg"),
	"group_up": preload("res://ping_icons/ping_icon_group_up.svg"),
	"heal": preload("res://ping_icons/ping_icon_heal.svg"),
	"heart": preload("res://ping_icons/ping_icon_heart.svg"),
	"help": preload("res://ping_icons/ping_icon_help.svg"),
	"question": preload("res://ping_icons/ping_icon_question.svg"),
	"quick": preload("res://ping_icons/ping_icon_quick.svg"),
	"retreat": preload("res://ping_icons/ping_icon_retreat.svg"),
	"shop": preload("res://ping_icons/ping_icon_shop.svg"),
	"thanks": preload("res://ping_icons/ping_icon_thanks.svg")
}
const NO_ICON = preload("res://no_icon.png")


func get_texture(icon) -> Texture2D:
	return ICON_LIST.get(icon, NO_ICON)
