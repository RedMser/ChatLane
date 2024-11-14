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
                          Tick the checkbox to allow assigning them in the game settings.
vc-category-wip = Work in Progress
vc-category-wip-help = These voice lines are not fully implemented for every character yet. You may hear nothing when using these, depending on your hero.
                       Tick the checkbox to allow selecting them in the Chat Wheel settings in-game.
vc-category-broken = Broken / Internal
vc-category-broken-help = Some voice lines are used internally (for post-game chat), or are broken when selected from the chat wheel
                          (e.g. ping voice lines that need a target entity).
                          Tick the checkbox to allow selecting them via the in-game settings, at your own risk.

vc-delete-tooltip = Delete voice command from this menu.
vc-enabled-tooltip = Whether this voice command should be selectable in the in-game settings.

# TODO: translate the list items (via vcDB class?)

# Custom Menus
cm-title = Custom Menus
cm-add = Add Custom Menu
cm-delete = Delete Menu
cm-default-name = New Custom Menu
cm-name = Name: 
cm-icon = Icon: 
cm-items = Voice Commands: 
cm-items-empty-state = Drag & Drop voice commands from the left list into here to add them to this menu.

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
alert-locate-no-vpks = The folder you selected does not seem to contain any add-on VPK files.
                       Try a folder like steamapps/common/Deadlock/game/citadel/addons
alert-locate-results = { $count ->
    [0] None of the add-on VPKs in the selected folder contain Chat Wheel configs.
    [1] { $vpks } contains your Chat Wheel config.
   *[other] Following { $count } VPKs contain Chat Wheel configs:
            { $vpks }
}
alert-invalid-file-extension = File does not have a valid file extension!
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
