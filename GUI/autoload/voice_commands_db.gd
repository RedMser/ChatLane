extends Node

const VC_LIST = [
	{ "id": "Can Heal", "category": "default", "label": "vc-item-can_heal", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Defend Lane", "category": "default", "label": "vc-item-defend_lane", "isMenu": true, "bindable": true, "pingWheelBindable": false },
	{ "id": "Going In", "category": "default", "label": "vc-item-going_in", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Good Job", "category": "default", "label": "vc-item-good_job", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Headed to Lane", "category": "default", "label": "vc-item-headed_to_lane", "isMenu": true, "bindable": true, "pingWheelBindable": false },
	{ "id": "Headed To Shop/Base", "category": "default", "label": "vc-item-headed_to_shop_base", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Help With Idol", "category": "default", "label": "vc-item-help_with_idol", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Help", "category": "default", "label": "vc-item-help", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Leave Area", "category": "default", "label": "vc-item-leave_area", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Need Heal", "category": "default", "label": "vc-item-need_heal", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "No", "category": "default", "label": "vc-item-no", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "On My Way", "category": "default", "label": "vc-item-on_my_way", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Push Lane", "category": "default", "label": "vc-item-push_lane", "isMenu": true, "bindable": true, "pingWheelBindable": false },
	{ "id": "Retreat", "category": "default", "label": "vc-item-retreat", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Sorry", "category": "default", "label": "vc-item-sorry", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Stay Together", "category": "default", "label": "vc-item-stay_together", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Thanks", "category": "default", "label": "vc-item-thanks", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Need Plan", "category": "default", "label": "vc-item-need_plan", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Yes", "category": "default", "label": "vc-item-yes", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "You\\'re Welcome", "category": "default", "label": "vc-item-youre_welcome", "isMenu": false, "bindable": true, "pingWheelBindable": true },

	{ "id": "Defend Blue", "category": "hidden", "label": "vc-item-defend_blue", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Defend Green", "category": "hidden", "label": "vc-item-defend_green", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Defend Purple", "category": "hidden", "label": "vc-item-defend_purple", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Defend Yellow", "category": "hidden", "label": "vc-item-defend_yellow", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Headed to Blue Subnav", "category": "hidden", "label": "vc-item-headed_to_blue", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Heading to Green Subnav", "category": "hidden", "label": "vc-item-heading_to_green", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Headed to Purple Subnav", "category": "hidden", "label": "vc-item-headed_to_purple", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Heading to Yellow Subnav", "category": "hidden", "label": "vc-item-heading_to_yellow", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Push Blue", "category": "hidden", "label": "vc-item-push_blue", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Push Green", "category": "hidden", "label": "vc-item-push_green", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Push Purple", "category": "hidden", "label": "vc-item-push_purple", "isMenu": false, "bindable": false, "pingWheelBindable": true },
	{ "id": "Push Yellow", "category": "hidden", "label": "vc-item-push_yellow", "isMenu": false, "bindable": false, "pingWheelBindable": true },

	{ "id": "Good Game (Post Game) - All Chat", "category": "broken", "label": "vc-item-good_game_post_game_all_chat", "isMenu": false, "bindable": false, "pingWheelBindable": false },
	{ "id": "Good Job (Post Game) - All Chat", "category": "broken", "label": "vc-item-good_job_post_game_all_chat", "isMenu": false, "bindable": false, "pingWheelBindable": false },
	{ "id": "Thanks (Post Game) - All Chat", "category": "broken", "label": "vc-item-thanks_post_game_all_chat", "isMenu": false, "bindable": false, "pingWheelBindable": false },
	{ "id": "Well Played (Post Game) - All Chat", "category": "broken", "label": "vc-item-well_played_post_game_all_chat", "isMenu": false, "bindable": false, "pingWheelBindable": false },
	{ "id": "Missing", "category": "broken", "label": "vc-item-missing", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Pinged Enemy Player", "category": "broken", "label": "vc-item-pinged_enemy_player", "isMenu": false, "bindable": false, "pingWheelBindable": false },
	{ "id": "Pinged Teammate", "category": "broken", "label": "vc-item-pinged_teammate", "isMenu": false, "bindable": false, "pingWheelBindable": false },

	{ "id": "Going to Shop", "category": "default", "label": "vc-item-going_to_shop", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Request Follow", "category": "default", "label": "vc-item-request_follow", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Going to Gank", "category": "default", "label": "vc-item-going_to_gank", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Rejuv Drop", "category": "default", "label": "vc-item-rejuv_drop", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Need Cover", "category": "default", "label": "vc-item-need_cover", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Nevermind", "category": "default", "label": "vc-item-nevermind", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "No Teamfight", "category": "default", "label": "vc-item-no_teamfight", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Press The Advantage", "category": "default", "label": "vc-item-press_the_advantage", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Lets Hide Here", "category": "default", "label": "vc-item-lets_hide_here", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Its Dangerous", "category": "default", "label": "vc-item-its_dangerous", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "I\\'ll Clear Troopers", "category": "default", "label": "vc-item-ill_clear_troopers", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Meet Here", "category": "default", "label": "vc-item-meet_here", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Flank", "category": "default", "label": "vc-item-flank", "isMenu": false, "bindable": true, "pingWheelBindable": true },
	{ "id": "Pregame Pings", "category": "broken", "label": "vc-item-pregame_pings", "isMenu": false, "bindable": false, "pingWheelBindable": false },
]

signal add_voice_command(id: String)


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
