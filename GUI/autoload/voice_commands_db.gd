extends Node

const VC_LIST = [
	{ "id": "Can Heal", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-can_heal", "isMenu": false },
	{ "id": "Defend Lane", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-defend_lane", "isMenu": true },
	{ "id": "Going In", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-going_in", "isMenu": false },
	{ "id": "Good Job", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-good_job", "isMenu": false },
	{ "id": "Headed to Lane", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-headed_to_lane", "isMenu": true },
	{ "id": "Headed To Shop/Base", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-headed_to_shop_base", "isMenu": false },
	{ "id": "Help With Idol", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-help_with_idol", "isMenu": false },
	{ "id": "Help", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-help", "isMenu": false },
	{ "id": "Need Heal", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-need_heal", "isMenu": false },
	{ "id": "No", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-no", "isMenu": false },
	{ "id": "On My Way", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-on_my_way", "isMenu": false },
	{ "id": "Push Lane", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-push_lane", "isMenu": true },
	{ "id": "Retreat", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-retreat", "isMenu": false },
	{ "id": "Sorry", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-sorry", "isMenu": false },
	{ "id": "Stay Together", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-stay_together", "isMenu": false },
	{ "id": "Thanks", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-thanks", "isMenu": false },
	{ "id": "Need Plan", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-need_plan", "isMenu": false },
	{ "id": "Yes", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-yes", "isMenu": false },
	{ "id": "You\\'re Welcome", "enabled": true, "canDisable": false, "category": "default", "label": "vc-item-youre_welcome", "isMenu": false },

	{ "id": "Defend Blue", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-defend_blue", "isMenu": false },
	{ "id": "Defend Green", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-defend_green", "isMenu": false },
	{ "id": "Defend Purple", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-defend_purple", "isMenu": false },
	{ "id": "Defend Yellow", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-defend_yellow", "isMenu": false },
	{ "id": "Headed to Blue Subnav", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-headed_to_blue", "isMenu": false },
	{ "id": "Heading to Green Subnav", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-heading_to_green", "isMenu": false },
	{ "id": "Headed to Purple Subnav", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-headed_to_purple", "isMenu": false },
	{ "id": "Heading to Yellow Subnav", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-heading_to_yellow", "isMenu": false },
	{ "id": "Push Blue", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-push_blue", "isMenu": false },
	{ "id": "Push Green", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-push_green", "isMenu": false },
	{ "id": "Push Purple", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-push_purple", "isMenu": false },
	{ "id": "Push Yellow", "enabled": true, "canDisable": true, "category": "hidden", "label": "vc-item-push_yellow", "isMenu": false },

	{ "id": "Good Game (Post Game) - All Chat", "enabled": true, "canDisable": true, "category": "broken", "label": "vc-item-good_game_post_game_all_chat", "isMenu": false },
	{ "id": "Good Job (Post Game) - All Chat", "enabled": true, "canDisable": true, "category": "broken", "label": "vc-item-good_job_post_game_all_chat", "isMenu": false },
	{ "id": "Thanks (Post Game) - All Chat", "enabled": true, "canDisable": true, "category": "broken", "label": "vc-item-thanks_post_game_all_chat", "isMenu": false },
	{ "id": "Well Played (Post Game) - All Chat", "enabled": true, "canDisable": true, "category": "broken", "label": "vc-item-well_played_post_game_all_chat", "isMenu": false },
	{ "id": "Missing", "enabled": true, "canDisable": true, "category": "broken", "label": "vc-item-missing", "isMenu": false },
	{ "id": "Pinged Enemy Player", "enabled": true, "canDisable": true, "category": "broken", "label": "vc-item-pinged_enemy_player", "isMenu": false },
	{ "id": "Pinged Teammate", "enabled": true, "canDisable": true, "category": "broken", "label": "vc-item-pinged_teammate", "isMenu": false }
]



func grouped_by_categories() -> Dictionary:
	var res := {}
	
	for item in VC_LIST:
		if item["category"] not in res:
			res[item["category"]] = []
		res[item["category"]].append(item)
	
	return res


func category_get_help_text(category: String) -> String:
	var msg = "vc-category-%s-help" % category
	if tr(msg) == msg:
		# untranslated
		return ""
	else:
		return msg


func find(id: String) -> Dictionary:
	var index = VC_LIST.find_custom(func(item): return item["id"] == id)
	if index < 0:
		return {}
	else:
		return VC_LIST[index]


## Which voice lines should have an overridden bindable status by default.
func get_bindable_overrides() -> Dictionary:
	return { "Missing": true }
