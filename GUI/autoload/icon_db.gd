extends Node


const DARK_COLOR = Color(0.049, 0.039, 0.026)

const ICON_LIST := {
	"defend": { "label": "Defend", "texture": preload("res://ping_icons/ping_icon_defend.svg") },
	"going_in": { "label": "Going In", "texture": preload("res://ping_icons/ping_icon_going_in.svg") },
	"group_up": { "label": "Group Up", "texture": preload("res://ping_icons/ping_icon_group_up.svg") },
	"heal": { "label": "Heal", "texture": preload("res://ping_icons/ping_icon_heal.svg") },
	"heart": { "label": "Heart", "texture": preload("res://ping_icons/ping_icon_heart.svg") },
	"help": { "label": "Help", "texture": preload("res://ping_icons/ping_icon_help.svg") },
	"question": { "label": "Question", "texture": preload("res://ping_icons/ping_icon_question.svg") },
	"quick": { "label": "Quick", "texture": preload("res://ping_icons/ping_icon_quick.svg") },
	"retreat": { "label": "Retreat", "texture": preload("res://ping_icons/ping_icon_retreat.svg") },
	"shop": { "label": "Shop", "texture": preload("res://ping_icons/ping_icon_shop.svg") },
	"thanks": { "label": "Thanks", "texture": preload("res://ping_icons/ping_icon_thanks.svg") }
}
const NO_ICON = preload("res://no_icon.png")


func get_texture(icon) -> Texture2D:
	if !icon:
		return NO_ICON
	var entry = ICON_LIST.get(icon)
	if !entry:
		return null
	return entry.texture
