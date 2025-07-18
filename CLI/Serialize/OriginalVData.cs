using System.Text;
using System.Text.RegularExpressions;
using ValveResourceFormat.Serialization.KeyValues;

public static class OriginalVData
{
    public static KVObject GetData()
    {
        // scripts/ping_wheel_messages.vdata extracted at 9th May 2025.
        var contents = """
<!-- kv3 encoding:text:version{e21c7f3c-8a33-41c5-9977-a76d3a32aa0d} format:generic:version{7412167c-06e9-4698-aff2-e63eb59037e7} -->
{
	generic_data_type = "PingWheelMessage_t"
	"Going In" = 
	{
		m_strLabelToken = "#citadel_chatwheel_label_GoingIn"
		m_strIcon = "file://{images}/hud/ping/ping_icon_going_in.svg"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerOnSender"
		m_ePingConcept = "CITADEL_PING_GOING_IN"
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_MAP_PING"
		m_eRecipientsType = "k_ECitadelRecipients_GlobalFriendlyTeam"
		m_strMessageToken = "#citadel_chatwheel_label_GoingIn"
		m_unPingWheelOptionID = 1
		m_bBindable = true
		m_flPhraseTopMarginOffset = 50.000000
		m_bPingWheelBindable = true
	}
	Help = 
	{
		m_strLabelToken = "#citadel_chatwheel_label_Help"
		m_strIcon = "file://{images}/hud/ping/ping_icon_help.svg"
		m_ePingConcept = "CITADEL_PING_HELP"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerOnSender"
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_WARNING"
		m_strMessageToken = "#citadel_chatwheel_message_Help"
		m_unPingWheelOptionID = 2
		m_bBindable = true
		m_flPhraseTopMarginOffset = 50.000000
		m_bPingWheelBindable = true
	}
	Yes = 
	{
		m_strLabelToken = "#citadel_chatwheel_label_Yes"
		m_strMessageToken = "#citadel_chatwheel_message_Yes"
		m_strIcon = "file://{images}/hud/ping/ping_icon_quick.svg"
		m_ePingConcept = "CITADEL_PING_YES"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_unPingWheelOptionID = 3
		m_bPingWheelBindable = true
		m_bBindable = true
		m_vecRespondsToConcepts = 
		[
			"CITADEL_PING_ATTACK_ENEMY",
			"CITADEL_PING_GET_BACK",
			"CITADEL_PING_STAY_TOGETHER",
			"CITADEL_PING_RETREAT",
			"CITADEL_PING_HELP_WITH_IDOL",
			"CITADEL_PING_REQUEST_FOLLOW",
		]
	}
	Thanks = 
	{
		m_strLabelToken = "#citadel_chatwheel_label_thanks"
		m_strMessageToken = "#citadel_chatwheel_label_thanks"
		m_strIcon = "file://{images}/hud/ping/ping_icon_heart.svg"
		m_eRecipientsType = "k_ECitadelRecipients_GlobalFriendlyTeam"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_ePingConcept = "CITADEL_PING_THANK_YOU"
		m_unPingWheelOptionID = 4
		m_bBindable = true
		m_flPhraseTopMarginOffset = 40.000000
		m_bPingWheelBindable = true
	}
	Retreat = 
	{
		m_strLabelToken = "#citadel_chatwheel_label_retreat"
		m_strMessageToken = "#citadel_chatwheel_label_retreat"
		m_strIcon = "file://{images}/hud/ping/ping_icon_retreat.svg"
		m_ePingConcept = "CITADEL_PING_RETREAT"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_OnlyPlaySound"
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_WARNING"
		m_unPingWheelOptionID = 5
		m_bBindable = true
		m_flPhraseTopMarginOffset = 40.000000
		m_bPingWheelBindable = true
	}
	"Stay Together" = 
	{
		m_strLabelToken = "#citadel_chatwheel_label_StayTogether"
		m_strMessageToken = "#citadel_chatwheel_message_StayTogether"
		m_strIcon = "file://{images}/hud/ping/ping_icon_group_up.svg"
		m_ePingConcept = "CITADEL_PING_STAY_TOGETHER"
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_WARNING"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_OnlyPlaySound"
		m_unPingWheelOptionID = 6
		m_bBindable = true
		m_bPingWheelBindable = true
	}
	"Defend Lane" = 
	{
		m_strLabelToken = "#citadel_chatwheel_label_Defend"
		m_strMessageToken = "#citadel_chatwheel_message_Defend"
		m_strIcon = "file://{images}/hud/ping/ping_icon_defend.svg"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_OnlyPlaySound"
		m_ePingConcept = "CITADEL_PING_DEFEND_LANE"
		m_unPingWheelOptionID = 7
		m_bIsSubnavMessage = false
		m_vecSubnavMessageNames = 
		[
			"Defend Yellow",
			"Defend Blue",
			"Defend Green",
			"Defend Purple",
		]
		m_bBindable = true
	}
	"Defend Yellow" = 
	{
		m_bIsSubnavMessage = true
		m_strLabelToken = "#citadel_chatwheel_message_Defend_Yellow"
		m_strMessageToken = "#citadel_chatwheel_message_Defend_Yellow"
		m_unPingWheelOptionID = 8
		m_ePingConcept = "CITADEL_PING_DEFEND_LANE"
		m_eLaneColor = "k_ELaneColor_Yellow"
		m_bPingWheelBindable = true
		m_bBindable = false
	}
	"Defend Green" = 
	{
		m_bIsSubnavMessage = true
		m_strLabelToken = "#citadel_chatwheel_message_Defend_Green"
		m_strMessageToken = "#citadel_chatwheel_message_Defend_Green"
		m_unPingWheelOptionID = 9
		m_ePingConcept = "CITADEL_PING_DEFEND_LANE"
		m_eLaneColor = "k_ELaneColor_Green"
		m_bPingWheelBindable = true
		m_bBindable = false
	}
	"Defend Blue" = 
	{
		m_bIsSubnavMessage = true
		m_strLabelToken = "#citadel_chatwheel_message_Defend_Blue"
		m_strMessageToken = "#citadel_chatwheel_message_Defend_Blue"
		m_unPingWheelOptionID = 10
		m_ePingConcept = "CITADEL_PING_DEFEND_LANE"
		m_eLaneColor = "k_ELaneColor_Blue"
		m_bPingWheelBindable = true
		m_bBindable = false
	}
	"Defend Purple" = 
	{
		m_bIsSubnavMessage = true
		m_strLabelToken = "#citadel_chatwheel_message_Defend_Purple"
		m_strMessageToken = "#citadel_chatwheel_message_Defend_Purple"
		m_unPingWheelOptionID = 11
		m_ePingConcept = "CITADEL_PING_DEFEND_LANE"
		m_eLaneColor = "k_ELaneColor_Purple"
		m_bPingWheelBindable = true
	}
	"Headed To Shop/Base" = 
	{
		m_unPingWheelOptionID = 12
		m_strLabelToken = "#citadel_chatwheel_label_BRB"
		m_strMessageToken = "#citadel_chatwheel_message_BRB"
		m_ePingConcept = "CITADEL_PING_HEADED_TO_BASE"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_strIcon = "file://{images}/hud/ping/ping_icon_shop.svg"
		m_bBindable = true
		m_bPingWheelBindable = true
	}
	No = 
	{
		m_unPingWheelOptionID = 17
		m_strLabelToken = "#citadel_chatwheel_label_No"
		m_strMessageToken = "#citadel_chatwheel_label_No"
		m_ePingConcept = "CITADEL_PING_NO"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_bPingWheelBindable = true
		m_bBindable = true
	}
	"Good Job" = 
	{
		m_unPingWheelOptionID = 18
		m_strLabelToken = "#citadel_chatwheel_label_GoodJob"
		m_strMessageToken = "#citadel_chatwheel_message_GoodJob"
		m_ePingConcept = "CITADEL_PING_GOOD_JOB"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_eRecipientsType = "k_ECitadelRecipients_RecipientsAroundPlayer"
		m_strIcon = "file://{images}/hud/ping/ping_icon_thanks.svg"
		m_bBindable = true
		m_flPhraseTopMarginOffset = 50.000000
		m_bPingWheelBindable = true
	}
	"Good Game (Post Game) - All Chat" = 
	{
		m_unPingWheelOptionID = 19
		m_strLabelToken = "#citadel_chatwheel_label_GoodGame"
		m_strMessageToken = "#citadel_chatwheel_message_GoodGame"
		m_strIcon = "file://{images}/hud/ping/ping_icon_thanks.svg"
		m_ePingConcept = "CITADEL_PING_GOOD_GAME_ALLCHAT"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_eRecipientsType = "k_ECitadelRecipients_GlobalAllChat"
	}
	"Well Played (Post Game) - All Chat" = 
	{
		m_unPingWheelOptionID = 20
		m_strLabelToken = "#citadel_chatwheel_label_WellPlayed"
		m_strMessageToken = "#citadel_chatwheel_message_WellPlayed"
		m_ePingConcept = "CITADEL_PING_WELL_PLAYED_ALLCHAT"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_eRecipientsType = "k_ECitadelRecipients_GlobalAllChat"
		m_strIcon = "file://{images}/hud/ping/ping_icon_thanks.svg"
	}
	"Thanks (Post Game) - All Chat" = 
	{
		m_unPingWheelOptionID = 21
		m_strLabelToken = "#citadel_chatwheel_label_thanksGameOver"
		m_strMessageToken = "#citadel_chatwheel_message_thanksGameOver"
		m_ePingConcept = "CITADEL_PING_THANKS_ALLCHAT"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_eRecipientsType = "k_ECitadelRecipients_GlobalFriendlyTeam"
		m_strIcon = "file://{images}/hud/ping/ping_icon_thanks.svg"
	}
	"Good Job (Post Game) - All Chat" = 
	{
		m_unPingWheelOptionID = 22
		m_strLabelToken = "#citadel_chatwheel_label_GoodJobGameOver"
		m_strMessageToken = "#citadel_chatwheel_message_GoodJobGameOver"
		m_ePingConcept = "CITADEL_PING_GOODJOB_ALLCHAT"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_eRecipientsType = "k_ECitadelRecipients_GlobalAllChat"
		m_strIcon = "file://{images}/hud/ping/ping_icon_thanks.svg"
	}
	"On My Way" = 
	{
		m_unPingWheelOptionID = 23
		m_ePingConcept = "CITADEL_PING_ON_MY_WAY"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_strLabelToken = "#citadel_chatwheel_label_OMW"
		m_strMessageToken = "#citadel_chatwheel_label_OMW"
		m_bPingWheelBindable = true
		m_bBindable = true
		m_vecRespondsToConcepts = 
		[
			"CITADEL_PING_LETS_GO_THIS_WAY",
			"CITADEL_PING_MID",
			"CITADEL_PING_PUSH_LANE",
			"CITADEL_PING_DEFEND_LANE",
			"CITADEL_PING_IDOL",
			"CITADEL_PING_HEADING_TO_LANE",
			"CITADEL_PING_MEET_HERE",
		]
		m_strIcon = ""
	}
	"Push Lane" = 
	{
		m_unPingWheelOptionID = 24
		m_ePingConcept = "CITADEL_PING_PUSH_LANE"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_strLabelToken = "#citadel_chatwheel_label_Push"
		m_strMessageToken = "#citadel_chatwheel_label_Push"
		m_bIsSubnavMessage = false
		m_strIcon = "file://{images}/hud/ping/ping_objective.svg"
		m_vecSubnavMessageNames = 
		[
			"Push Yellow",
			"Push Blue",
			"Push Green",
			"Push Purple",
		]
		m_bBindable = true
		m_flPhraseTopMarginOffset = 35.000000
	}
	"Push Yellow" = 
	{
		m_unPingWheelOptionID = 25
		m_ePingConcept = "CITADEL_PING_PUSH_LANE"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_strLabelToken = "#citadel_chatwheel_push_yellow"
		m_bIsSubnavMessage = true
		m_strMessageToken = "#citadel_chatwheel_push_yellow"
		m_eLaneColor = "k_ELaneColor_Yellow"
		m_flPhraseTopMarginOffset = 30.000000
	}
	"Push Green" = 
	{
		m_unPingWheelOptionID = 26
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_strLabelToken = "#citadel_chatwheel_push_green"
		m_strMessageToken = "#citadel_chatwheel_push_green"
		m_bIsSubnavMessage = true
		m_ePingConcept = "CITADEL_PING_PUSH_LANE"
		m_eLaneColor = "k_ELaneColor_Green"
		m_flPhraseTopMarginOffset = 30.000000
	}
	"Push Blue" = 
	{
		m_unPingWheelOptionID = 27
		m_ePingMarkerInfo = "k_EPingMarkerInfo_HideMarkerAndSound"
		m_bIsSubnavMessage = true
		m_strLabelToken = "#citadel_chatwheel_push_blue"
		m_strMessageToken = "#citadel_chatwheel_push_blue"
		m_ePingConcept = "CITADEL_PING_PUSH_LANE"
		m_eLaneColor = "k_ELaneColor_Blue"
		m_flPhraseTopMarginOffset = 30.000000
	}
	"Push Purple" = 
	{
		m_unPingWheelOptionID = 28
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerAndSound"
		m_bIsSubnavMessage = true
		m_ePingConcept = "CITADEL_PING_PUSH_LANE"
		m_eLaneColor = "k_ELaneColor_Purple"
		m_strLabelToken = "#citadel_chatwheel_push_purple"
		m_strMessageToken = "#citadel_chatwheel_push_purple"
		m_flPhraseTopMarginOffset = 30.000000
	}
	"Pinged Enemy Player" = 
	{
		m_unPingWheelOptionID = 29
		m_ePingConcept = "CITADEL_PING_ENEMY_PLAYER"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerAndSound"
		m_strLabelToken = "#ping_see"
		m_strMessageToken = "#ping_see"
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_ATTACK"
	}
	"Pinged Teammate" = 
	{
		m_unPingWheelOptionID = 30
		m_ePingConcept = "CITADEL_PING_TEAMMATE"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerAndSound"
		m_eRecipientsType = "k_ECitadelRecipients_RecipientAndPlayer"
		m_strLabelToken = "#ping_careful"
		m_strMessageToken = "#ping_careful"
	}
	Missing = 
	{
		m_unPingWheelOptionID = 31
		m_ePingConcept = "CITADEL_PING_MISSING"
		m_strLabelToken = "#citadel_chatwheel_label_missing"
		m_strMessageToken = "#citadel_chatwheel_message_missing_hero"
		m_flPhraseTopMarginOffset = 50.000000
		m_strIcon = "file://{images}/hud/ping/ping_icon_question.svg"
		m_bPingWheelBindable = true
	}
	"Need Heal" = 
	{
		m_unPingWheelOptionID = 32
		m_ePingConcept = "CITADEL_PING_NEED_HEAL"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_OnlyPlaySound"
		m_eRecipientsType = "k_ECitadelRecipients_RecipientsAroundPlayer"
		m_strLabelToken = "#citadel_chatwheel_need_heal"
		m_strMessageToken = "#citadel_chatwheel_heal_please"
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_WARNING"
		m_bBindable = true
		m_flPhraseTopMarginOffset = 50.000000
		m_strIcon = "file://{images}/hud/ping/ping_icon_heal.svg"
		m_bPingWheelBindable = true
	}
	"Can Heal" = 
	{
		m_unPingWheelOptionID = 33
		m_ePingConcept = "CITADEL_PING_HAVE_HEAL"
		m_eRecipientsType = "k_ECitadelRecipients_RecipientsAroundPlayer"
		m_strLabelToken = "#citadel_chatwheel_have_heal"
		m_strMessageToken = "#citadel_chatwheel_can_heal"
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_WARNING"
		m_bBindable = true
		m_flPhraseTopMarginOffset = 50.000000
		m_strIcon = "file://{images}/hud/ping/ping_icon_heal.svg"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerOnSender"
		m_bPingWheelBindable = true
	}
	"Need Plan" = 
	{
		m_unPingWheelOptionID = 34
		m_ePingConcept = "CITADEL_PING_NEED_PLAN"
		m_strLabelToken = "#citadel_chatwheel_need_plan"
		m_strMessageToken = "#citadel_chatwheel_need_plan"
		m_bBindable = true
		m_flPhraseTopMarginOffset = 25.000000
		m_strIcon = "file://{images}/hud/ping/ping_icon_question.svg"
		m_bPingWheelBindable = true
	}
	"Heading to Yellow Subnav" = 
	{
		m_unPingWheelOptionID = 38
		m_ePingConcept = "CITADEL_PING_HEADING_TO_LANE"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerOnSender"
		m_strLabelToken = "#citadel_chatwheel_message_HeadedToYellow"
		m_strMessageToken = "#citadel_chatwheel_message_HeadedToYellow"
		m_eLaneColor = "k_ELaneColor_Yellow"
		m_strIcon = "file://{images}/hud/ping/ping_icon_going_in.svg"
		m_bIsSubnavMessage = true
		m_flPhraseTopMarginOffset = 30.000000
		m_bPingWheelBindable = true
	}
	"Heading to Green Subnav" = 
	{
		m_unPingWheelOptionID = 39
		m_ePingConcept = "CITADEL_PING_HEADING_TO_LANE"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerOnSender"
		m_eLaneColor = "k_ELaneColor_Green"
		m_strMessageToken = "#citadel_chatwheel_message_HeadedToGreen"
		m_strLabelToken = "#citadel_chatwheel_message_HeadedToGreen"
		m_strIcon = "file://{images}/hud/ping/ping_icon_going_in.svg"
		m_bIsSubnavMessage = true
		m_flPhraseTopMarginOffset = 30.000000
		m_bPingWheelBindable = true
	}
	"Headed to Blue Subnav" = 
	{
		m_unPingWheelOptionID = 40
		m_ePingConcept = "CITADEL_PING_HEADING_TO_LANE"
		m_bIsSubnavMessage = true
		m_eLaneColor = "k_ELaneColor_Blue"
		m_strMessageToken = "#citadel_chatwheel_message_HeadedToBlue"
		m_strLabelToken = "#citadel_chatwheel_message_HeadedToBlue"
		m_flPhraseTopMarginOffset = 30.000000
		m_bPingWheelBindable = true
	}
	"Headed to Purple Subnav" = 
	{
		m_unPingWheelOptionID = 41
		m_ePingConcept = "CITADEL_PING_HEADING_TO_LANE"
		m_bIsSubnavMessage = true
		m_eLaneColor = "k_ELaneColor_Purple"
		m_strMessageToken = "#citadel_chatwheel_message_HeadedToPurple"
		m_strLabelToken = "#citadel_chatwheel_message_HeadedToPurple"
		m_flPhraseTopMarginOffset = 30.000000
		m_bPingWheelBindable = true
	}
	"Headed to Lane" = 
	{
		m_unPingWheelOptionID = 42
		m_ePingConcept = "CITADEL_PING_HEADING_TO_LANE"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerOnSender"
		m_vecSubnavMessageNames = 
		[
			"Heading to Yellow Subnav",
			"Headed to Blue Subnav",
			"Heading to Green Subnav",
			"Headed to Purple Subnav",
		]
		m_strMessageToken = ""
		m_strLabelToken = "#citadel_chatwheel_message_headed_to_lane"
		m_strIcon = "file://{images}/hud/ping/ping_icon_going_in.svg"
		m_bBindable = true
	}
	"Help With Idol" = 
	{
		m_unPingWheelOptionID = 43
		m_ePingConcept = "CITADEL_PING_HELP_WITH_IDOL"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerAndSound"
		m_strMessageToken = "#citadel_chatwheel_help_with_idol_message"
		m_strLabelToken = "#citadel_chatwheel_help_with_idol_label"
		m_bBindable = true
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_MAP_PING"
		m_bPingWheelBindable = true
		m_vecRespondsToConcepts = 
		[
		]
		m_strIcon = "file://{images}/hud/ping/ping_icon_help.svg"
	}
	"You\'re Welcome" = 
	{
		m_unPingWheelOptionID = 44
		m_ePingConcept = "CITADEL_PING_YOURE_WELCOME"
		m_eRecipientsType = "k_ECitadelRecipients_RecipientsAroundPlayer"
		m_strLabelToken = "#citadel_chatwheel_youre_welcome"
		m_strMessageToken = "#citadel_chatwheel_youre_welcome"
		m_bBindable = true
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_NONE"
		m_flPhraseTopMarginOffset = 30.000000
		m_bPingWheelBindable = true
		m_vecRespondsToConcepts = 
		[
			"CITADEL_PING_THANK_YOU",
		]
		m_strIcon = "file://{images}/hud/ping/ping_icon_heart.svg"
	}
	Sorry = 
	{
		m_unPingWheelOptionID = 45
		m_ePingConcept = "CITADEL_PING_SORRY"
		m_strLabelToken = "#citadel_chatwheel_sorry"
		m_strMessageToken = "#citadel_chatwheel_sorry"
		m_bBindable = true
		m_flPhraseTopMarginOffset = 40.000000
		m_bPingWheelBindable = true
		m_strIcon = "file://{images}/hud/ping/ping_icon_heart.svg"
	}
	"Going to Shop" = 
	{
		m_unPingWheelOptionID = 46
		m_ePingConcept = "CITADEL_PING_GOING_TO_SHOP"
		m_strLabelToken = "#citadel_chatwheel_going_shop"
		m_strMessageToken = "#citadel_chatwheel_going_shop"
		m_bBindable = true
		m_bPingWheelBindable = true
		m_strIcon = "file://{images}/hud/ping/ping_icon_shop.svg"
	}
	"Request Follow" = 
	{
		m_unPingWheelOptionID = 47
		m_ePingConcept = "CITADEL_PING_REQUEST_FOLLOW"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerOnSender"
		m_strLabelToken = "#citadel_chatwheel_message_Request_Follow"
		m_strMessageToken = "#citadel_chatwheel_message_Request_Follow"
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_MAP_PING"
		m_bBindable = true
		m_bPingWheelBindable = true
	}
	"Going to Gank" = 
	{
		m_unPingWheelOptionID = 48
		m_ePingConcept = "CITADEL_PING_GOING_TO_GANK"
		m_strLabelToken = "#citadel_chatwheel_message_gank"
		m_strMessageToken = "#citadel_chatwheel_message_gank"
		m_bPingWheelBindable = true
		m_bBindable = true
	}
	"Rejuv Drop" = 
	{
		m_unPingWheelOptionID = 49
		m_ePingConcept = "CITADEL_PING_REJUV_DROP"
		m_bBindable = true
		m_bPingWheelBindable = true
		m_strMessageToken = "#citadel_chatwheel_message_Rejuv_Drop"
		m_strLabelToken = "#citadel_chatwheel_label_Rejuv_Drop"
	}
	"Need Cover" = 
	{
		m_unPingWheelOptionID = 50
		m_ePingConcept = "CITADEL_PING_NEED_COVER"
		m_strLabelToken = "#citadel_chatwheel_label_need_cover"
		m_strMessageToken = "#citadel_chatwheel_message_need_cover"
		m_bBindable = true
		m_bPingWheelBindable = true
	}
	Nevermind = 
	{
		m_unPingWheelOptionID = 51
		m_strLabelToken = "#citadel_chatwheel_label_nevermind"
		m_strMessageToken = "#citadel_chatwheel_message_nevermind"
		m_bBindable = true
		m_bPingWheelBindable = true
		m_ePingConcept = "CITADEL_PING_NEVERMIND"
	}
	"No Teamfight" = 
	{
		m_unPingWheelOptionID = 52
		m_strLabelToken = "#citadel_chatwheel_label_no_teamfight"
		m_strMessageToken = "#citadel_chatwheel_message_no_teamfight"
		m_bBindable = true
		m_bPingWheelBindable = true
		m_ePingConcept = "CITADEL_PING_NO_TEAMFIGHT"
	}
	"Press The Advantage" = 
	{
		m_unPingWheelOptionID = 53
		m_strLabelToken = "#citadel_chatwheel_label_press_advantage"
		m_strMessageToken = "#citadel_chatwheel_message_press_advantage"
		m_ePingConcept = "CITADEL_PING_PRESS_ADVANTAGE"
		m_bBindable = true
		m_bPingWheelBindable = true
	}
	"Lets Hide Here" = 
	{
		m_unPingWheelOptionID = 54
		m_ePingConcept = "CITADEL_PING_LETS_HIDE"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerOnSender"
		m_strLabelToken = "#citadel_chatwheel_label_lets_hide"
		m_strMessageToken = "#citadel_chatwheel_message_lets_hide"
		m_bBindable = true
		m_bPingWheelBindable = true
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_MAP_PING"
	}
	"Its Dangerous" = 
	{
		m_unPingWheelOptionID = 55
		m_ePingConcept = "CITADEL_PING_DANGER_AREA"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerOnSender"
		m_strLabelToken = "#citadel_chatwheel_label_danger_area"
		m_strMessageToken = "#citadel_chatwheel_message_danger_area"
		m_bBindable = true
		m_bPingWheelBindable = true
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_ATTACK"
	}
	"I\'ll Clear Troopers" = 
	{
		m_unPingWheelOptionID = 56
		m_ePingConcept = "CITADEL_PING_CLEAR_TROOPERS"
		m_strLabelToken = "#citadel_chatwheel_label_clear_troopers"
		m_strMessageToken = "#citadel_chatwheel_message_clear_troopers"
		m_bBindable = true
		m_bPingWheelBindable = true
	}
	"Meet Here" = 
	{
		m_unPingWheelOptionID = 57
		m_ePingConcept = "CITADEL_PING_MEET_HERE"
		m_ePingMarkerInfo = "k_EPingMarkerInfo_ShowMarkerOnSender"
		m_strLabelToken = "#citadel_chatwheel_label_meet_here"
		m_strMessageToken = "#citadel_chatwheel_message_meet_here"
		m_bBindable = true
		m_bPingWheelBindable = true
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_MAP_PING"
	}
	Flank = 
	{
		m_unPingWheelOptionID = 58
		m_strLabelToken = "#citadel_chatwheel_label_flank"
		m_ePingConcept = "CITADEL_PING_FLANK"
		m_strMessageToken = "#citadel_chatwheel_message_flank"
		m_ePingWheelSoundType = "CITADEL_PING_WHEEL_SOUND_NONE"
		m_bBindable = true
		m_bPingWheelBindable = true
	}
	"Pregame Pings" = 
	{
		m_unPingWheelOptionID = 59
		m_ePingConcept = "CITADEL_PING_PREGAME"
		m_eRecipientsType = "k_ECitadelRecipients_GlobalAllChat"
	}
	"Leave Area" = 
	{
		m_unPingWheelOptionID = 60
		m_ePingConcept = "CITADEL_PING_LEAVE_AREA"
		m_eRecipientsType = "k_ECitadelRecipients_RecipientsAroundPlayer"
		m_strLabelToken = "#citadel_chatwheel_label_leaving_area"
		m_strMessageToken = "#citadel_chatwheel_message_leaving_area"
		m_bPingWheelBindable = true
		m_bBindable = true
	}
}
""";

        // HACK: workaround for KV3 parser bug, remove once fixed: https://github.com/ValveResourceFormat/ValveResourceFormat/issues/858
        var matches = Regex.Matches(contents, @"^\t"".+?""", RegexOptions.Multiline);
        foreach (var match in matches.ToList())
        {
            contents = contents.Remove(match.Index, match.Length).Insert(match.Index, match.Value.Replace(" ", "$"));
        }
        // END OF HACK

        using var stream = new MemoryStream(Encoding.UTF8.GetBytes(contents));
        var kv = KeyValues3.ParseKVFile(stream);

        // HACK: workaround for KV3 parser bug, remove once fixed: https://github.com/ValveResourceFormat/ValveResourceFormat/issues/858
        var propsToRemap = new List<string>();
        foreach (var prop in kv.Root.Properties)
        {
            if (prop.Key.Contains('$'))
            {
                propsToRemap.Add(prop.Key);
            }
        }
        foreach (var prop in propsToRemap)
        {
            var value = kv.Root.Properties[prop];
            var newKey = prop.Replace("$", " ").Replace("\"", "");
            if (value.Value is KVObject obj && obj.Key == prop)
            {
                var newObj = new KVObject(newKey, obj.IsArray, obj.Count);
                foreach (var copy in obj.Properties)
                {
                    newObj.AddProperty(copy.Key, copy.Value);
                }
                value = new KVValue(value.Type, newObj);
            }
            kv.Root.Properties.Remove(prop);
            kv.Root.Properties.Add(newKey, value);
        }
        // END OF HACK

        return kv.Root;
    }
}