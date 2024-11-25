extends Node

const VC_LIST = [
	{ "id": "Can Heal", "enabled": true, "category": "default", "label": "vc-item-can_heal", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Defend Lane", "enabled": true, "category": "default", "label": "vc-item-defend_lane", "isMenu": true, "bindable": true, "pingWheelBindable": false },
	{ "id": "Going In", "enabled": true, "category": "default", "label": "vc-item-going_in", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Good Job", "enabled": true, "category": "default", "label": "vc-item-good_job", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Headed to Lane", "enabled": true, "category": "default", "label": "vc-item-headed_to_lane", "isMenu": true, "bindable": true, "pingWheelBindable": false },
	{ "id": "Headed To Shop/Base", "enabled": true, "category": "default", "label": "vc-item-headed_to_shop_base", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Help With Idol", "enabled": true, "category": "default", "label": "vc-item-help_with_idol", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Help", "enabled": true, "category": "default", "label": "vc-item-help", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Need Heal", "enabled": true, "category": "default", "label": "vc-item-need_heal", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "No", "enabled": true, "category": "default", "label": "vc-item-no", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "On My Way", "enabled": true, "category": "default", "label": "vc-item-on_my_way", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Push Lane", "enabled": true, "category": "default", "label": "vc-item-push_lane", "isMenu": true, "bindable": true, "pingWheelBindable": false },
	{ "id": "Retreat", "enabled": true, "category": "default", "label": "vc-item-retreat", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Sorry", "enabled": true, "category": "default", "label": "vc-item-sorry", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Stay Together", "enabled": true, "category": "default", "label": "vc-item-stay_together", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Thanks", "enabled": true, "category": "default", "label": "vc-item-thanks", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Need Plan", "enabled": true, "category": "default", "label": "vc-item-need_plan", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Yes", "enabled": true, "category": "default", "label": "vc-item-yes", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "You\\'re Welcome", "enabled": true, "category": "default", "label": "vc-item-youre_welcome", "isMenu": false, "bindable": true, "pingWheelBindable": true },

	{ "id": "Defend Blue", "enabled": true, "category": "hidden", "label": "vc-item-defend_blue", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Defend Green", "enabled": true, "category": "hidden", "label": "vc-item-defend_green", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Defend Purple", "enabled": true, "category": "hidden", "label": "vc-item-defend_purple", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Defend Yellow", "enabled": true, "category": "hidden", "label": "vc-item-defend_yellow", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Headed to Blue Subnav", "enabled": true, "category": "hidden", "label": "vc-item-headed_to_blue", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Heading to Green Subnav", "enabled": true, "category": "hidden", "label": "vc-item-heading_to_green", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Headed to Purple Subnav", "enabled": true, "category": "hidden", "label": "vc-item-headed_to_purple", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Heading to Yellow Subnav", "enabled": true, "category": "hidden", "label": "vc-item-heading_to_yellow", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Push Blue", "enabled": true, "category": "hidden", "label": "vc-item-push_blue", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Push Green", "enabled": true, "category": "hidden", "label": "vc-item-push_green", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Push Purple", "enabled": true, "category": "hidden", "label": "vc-item-push_purple", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Push Yellow", "enabled": true, "category": "hidden", "label": "vc-item-push_yellow", "isMenu": false, "bindable": false, "pingWheelBindable": true },

	{ "id": "Good Game (Post Game) - All Chat", "enabled": true, "category": "broken", "label": "vc-item-good_game_post_game_all_chat", "isMenu": false, "bindable": false, "pingWheelBindable": false },
	{ "id": "Good Job (Post Game) - All Chat", "enabled": true, "category": "broken", "label": "vc-item-good_job_post_game_all_chat", "isMenu": false, "bindable": false, "pingWheelBindable": false },
	{ "id": "Thanks (Post Game) - All Chat", "enabled": true, "category": "broken", "label": "vc-item-thanks_post_game_all_chat", "isMenu": false, "bindable": false, "pingWheelBindable": false },
	{ "id": "Well Played (Post Game) - All Chat", "enabled": true, "category": "broken", "label": "vc-item-well_played_post_game_all_chat", "isMenu": false, "bindable": false, "pingWheelBindable": false },
	{ "id": "Missing", "enabled": true, "category": "broken", "label": "vc-item-missing", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Pinged Enemy Player", "enabled": true, "category": "broken", "label": "vc-item-pinged_enemy_player", "isMenu": false, "bindable": false, "pingWheelBindable": false },
	{ "id": "Pinged Teammate", "enabled": true, "category": "broken", "label": "vc-item-pinged_teammate", "isMenu": false, "bindable": false, "pingWheelBindable": false }
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
