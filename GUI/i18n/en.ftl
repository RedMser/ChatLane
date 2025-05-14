# General UI
menu-file = File
file-new = New Config...
file-load = Load...
file-load-tooltip = Load chat wheel options from a previously saved VPK add-on.
file-locate = Locate add-on VPKs...
file-save = Save...
file-save-tooltip = Save chat wheel options as a VPK add-on.
file-quit = Quit

menu-help = Help
help-repository = GitHub Repository
help-about = About...

language-title = Select a language:
language-confirm = Confirm

launch-disclaimer = [b]Disclaimer:[/b] Deadlock is in early alpha, so this tool and add-on [b]may stop working at any moment[/b].
                    As the tool edits a game file (specifically a script file), I am [b]not responsible for any bans for users of this tool[/b].
                    Valve does not have a clear stance on what's fair game when it comes to modding Deadlock yet!

config-load-error-template = Loading config failed: { $cause }
config-validation-error-template = { $message } (expected { $expect } but got { $actual })

about-1 = Developed by RedMser, released under MIT license
about-2 = For more information on licensing, usage and third-party software, see the repository or the included README.md file.
about-copyright = { $name } (c) { $copyright } licensed under { $license }

placeholder-unnamed = (Unnamed)
placeholder-no-icon = (No icon)

# Icons
icon-defend = Defend
icon-going_in = Going in
icon-group_up = Group up
icon-heal = Heal
icon-heart = Heart
icon-help = Help
icon-question = Question mark
icon-quick = Check mark
icon-retreat = Retreat
icon-shop = Shop/Base
icon-thanks = Thanks

# Voice Commands
vc-title = Voice Commands
vc-category-default = Default
vc-category-hidden = Hidden
vc-category-hidden-help = While these voice lines can be used in game, they can't be selected as Chat Wheel options by default.
                          Enable edit mode at the top, then tick the checkboxes to allow assigning them in the game settings.
vc-category-wip = Work in Progress
vc-category-wip-help = These voice lines are not fully implemented for every character yet. You may hear nothing when using these, depending on your hero.
                       Enable edit mode at the top, then tick the checkboxes to allow assigning them in the game settings.
vc-category-broken = Broken / Internal
vc-category-broken-help = Some voice lines are used internally (for post-game chat), or are broken when selected from the chat wheel
                          (e.g. ping voice lines that need a target entity).
                          Enable edit mode at the top, then tick the checkboxes to allow assigning them in the game settings, at your own risk.

vc-delete-tooltip = Delete voice command from this menu.
vs-bindable-tooltip = Whether this voice command should be selectable in the chat wheel settings.
vc-ping-bindable-tooltip = Whether this voice command should be bindable to a keyboard key in the settings.
vc-count = { $count } of { $limit }
vc-error-duplicate = This voice command exists multiple times in the same menu.
                     While this is valid and technically supported, it might be an accident.
vc-error-menu = Menus may not be nested within other menus.
vc-edit-button-tooltip = Edit voice commands list.

vc-item-can_heal = Can Heal
vc-item-defend_lane = Defend Lane ...
vc-item-going_in = Going In
vc-item-good_job = Good Job
vc-item-headed_to_lane = Headed to Lane ...
vc-item-headed_to_shop_base = Be Right Back
vc-item-help_with_idol = Help With Idol
vc-item-help = Help
vc-item-need_heal = Need Heal
vc-item-push_lane = Push Lane ...
vc-item-retreat = Retreat
vc-item-sorry = Sorry
vc-item-stay_together = Stay Together
vc-item-thanks = Thanks
vc-item-need_plan = What's the Plan?
vc-item-youre_welcome = You're Welcome

vc-item-defend_blue = Defend Blue
vc-item-defend_green = Defend Green
vc-item-defend_purple = Defend Purple
vc-item-defend_yellow = Defend Yellow
vc-item-headed_to_blue = Headed to Blue
vc-item-heading_to_green = Headed to Green
vc-item-headed_to_purple = Headed to Purple
vc-item-heading_to_yellow = Headed to Yellow
vc-item-push_blue = Push Blue
vc-item-push_green = Push Green
vc-item-push_purple = Push Purple
vc-item-push_yellow = Push Yellow

vc-item-no = No
vc-item-on_my_way = On My Way
vc-item-yes = Yes

vc-item-good_game_post_game_all_chat = Good Game [ALL CHAT]
vc-item-good_job_post_game_all_chat = Good Job [ALL CHAT]
vc-item-thanks_post_game_all_chat = Thanks (Post Game)
vc-item-well_played_post_game_all_chat = Well Played [ALL CHAT]
vc-item-missing = (Enemy) is Missing
vc-item-pinged_enemy_player = I see (Enemy)
vc-item-pinged_teammate = Careful (Teammate)

vc-item-going_to_shop = Going to Shop
vc-item-request_follow = Come with Me!
vc-item-going_to_gank = Going to Gank
vc-item-rejuv_drop = Rejuv's Dropping
vc-item-need_cover = Cover Me
vc-item-nevermind = Nevermind
vc-item-no_teamfight = Not Ready For Teamfight
vc-item-press_the_advantage = Press The Advantage
vc-item-lets_hide_here = Let's Hide Here
vc-item-its_dangerous = It's Dangerous
vc-item-ill_clear_troopers = I'll Clear Troopers
vc-item-meet_here = Meet Here
vc-item-flank = I'll Flank
vc-item-pregame_pings = Pregame Taunt [ALL CHAT]
vc-item-leave_area = Leave Area

# Custom Menus
cm-title = Custom Menus
cm-add = Add Custom Menu
cm-delete = Delete Menu
cm-default-name = New Custom Menu
cm-name = Name: 
cm-icon = Icon: 
cm-items = Voice Commands: 
cm-items-empty-state = Double-click or drag & drop voice commands from the left list into here to add them to this menu.
cm-items-preview = Preview:
cm-items-preview-explain = Click on the inner circle segments to preview how the custom menu would appear in the chat wheel.
cm-items-preview-bug = Due to a bug in Deadlock itself, assigning a menu to the top will make it open on the bottom of the chat wheel.

# Dialogs
dialog-ok = OK
dialog-cancel = Cancel
dialog-reset-title = Reset Config?
dialog-reset-text = Would you like to reset all settings to their default?
                    You can always disable the chat wheel add-on by removing or renaming the .vpk file instead.
dialog-reset-ok = Reset all settings
dialog-unsaved-exit-title = Save changes?
dialog-unsaved-exit-text = You have unsaved changes!
                           Please save your config as a VPK add-on if you want to use it.
dialog-unsaved-exit-ok = Save and Quit...
dialog-unsaved-exit-quit = Quit without saving
dialog-unsaved-load-title = Save changes?
dialog-unsaved-load-text = You have unsaved changes!
                           Please save your config as a VPK add-on if you want to use it.
dialog-unsaved-load-ok = Save...
dialog-unsaved-load-continue = Discard changes
dialog-about-title = About
dialog-locate-title = Select your Deadlock addons folder to discover which VPKs contain chat wheel config
dialog-load-title = Load VPK file
dialog-save-title = Save VPK file
dialog-alert-title = Info
dialog-delete-menu-title = Delete custom menu
dialog-delete-menu-text = Delete this custom menu?
                          You will permanently lose all changes done to it.
dialog-delete-menu-ok = Delete
dialog-vc-section-help-title = Help
dialog-filter-vpk-addon = VPK Addon
dialog-filter-vpk-file = VPK File
dialog-filter-config = Chat Wheel Config
dialog-custom-menu-limit-title = About Custom Menus
dialog-custom-menu-limit-text = Deadlock has voice command menus which you can bind in the chat wheel (e.g. "Push Lane ...").
                                This tool allows you to create custom menus, which get added to the chat wheel settings list.
                                
                                As of 13th Nov. 2024, Deadlock has a bug that only allows a single menu to be active
                                on your chat wheel at the same time. While the tool allows creating multiple, you currently
                                won't be able to use multiple at once, due to this bug.
alert-locate-no-vpks = The folder you selected does not seem to contain any add-on VPK files.
                       Try a folder like steamapps/common/Deadlock/game/citadel/addons
alert-locate-results = { $count ->
    [0] None of the add-on VPKs in the selected folder contain Chat Wheel configs.
    [1] { $vpks } contains your Chat Wheel config.
   *[other] Following { $count } VPKs contain Chat Wheel configs:
            { $vpks }
}
alert-invalid-file-extension = File does not have a valid file extension!
alert-files-dropped-multiple = You can only drag & drop a single config file onto ChatLane to load it.
error-cli-generic = Unable to run the CLI tool.
                    Check the console for more details, and report this as an issue on GitHub.
error-cli-cant-fork = Unable to launch CLI app.
                      Make sure you've extracted the zip archive of ChatLane,
                      and did not rename, move or delete any files.
error-cli-already-in-use = Unable to access the selected file.
                           Make sure you've closed any applications that might be using this file,
                           such as Deadlock or Source2Viewer.
error-cli-file-unrecognized = The selected VPK file does not contain Chat Wheel config.
                              You can try the \"File -> Locate add-on VPKs...\" option to find the correct VPK.
