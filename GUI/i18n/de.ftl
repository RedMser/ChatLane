# General UI
menu-file = Datei
file-new = Neue Konfiguration...
file-load = Laden...
file-load-tooltip = Lade Chatrad-Optionen aus einem zuvor gespeicherten VPK-Add-on.
file-locate = Add-on-VPKs suchen...
file-save = Speichern...
file-save-tooltip = Speichere Chatrad-Optionen als VPK-Add-on.
file-quit = Beenden

menu-help = Hilfe
help-repository = GitHub-Repository
help-about = Über...

language-title = Sprache auswählen:
language-confirm = Bestätigen

launch-disclaimer = [b]Haftungsausschluss:[/b] Deadlock befindet sich in der frühen Alpha-Phase, daher können dieses Tool und Add-on [b]jederzeit nicht mehr funktionieren[/b].
                    Da das Tool eine Spieledatei bearbeitet (genauer gesagt eine Skriptdatei), übernehme ich [b]keine Verantwortung für eventuelle Banns von Nutzern dieses Tools[/b].
                    Valve hat noch keine klare Haltung dazu, was beim Modding von Deadlock erlaubt ist!

config-load-error-template = Laden der Konfiguration fehlgeschlagen: { $cause }
config-validation-error-template = { $message } ({ $expect } erwartet, aber { $actual } erhalten)

about-1 = Entwickelt von RedMser, veröffentlicht unter der MIT-Lizenz
about-2 = Für weitere Informationen zu Lizenzierung, Nutzung und Drittanbieter-Software siehe das Repository oder die beiliegende README.md Datei.
about-copyright = { $name } (c) { $copyright } lizenziert unter { $license }

placeholder-unnamed = (Unbenannt)
placeholder-no-icon = (Kein Symbol)

# Icons
icon-defend = Verteidigen
icon-going_in = Ich gehe rein
icon-group_up = Zusammenkommen
icon-heal = Heilen
icon-heart = Herz
icon-help = Hilfe
icon-question = Fragezeichen
icon-quick = Häkchen
icon-retreat = Rückzug
icon-shop = Shop/Basis
icon-thanks = Danke

# Voice Commands
vc-title = Sprachbefehle
vc-category-default = Standard
vc-category-hidden = Versteckt
vc-category-hidden-help = Diese Sprachzeilen können im Spiel verwendet werden, aber sie können standardmäßig nicht als Chatrad-Optionen ausgewählt werden.
                          Kreuzen Sie das Häkchen an, um die Auswahl im Spielmenü zu ermöglichen.
vc-category-wip = In Bearbeitung
vc-category-wip-help = Diese Sprachzeilen sind noch nicht für jeden Charakter vollständig implementiert. Es kann vorkommen, dass nichts zu hören ist, abhängig von deiner Heldenwahl.
                       Kreuzen Sie das Häkchen an, um sie in den Chatrad-Einstellungen im Spiel auswählen zu können.
vc-category-broken = Defekt / Intern
vc-category-broken-help = Einige Sprachzeilen werden intern verwendet (z.B. für den Chat nach dem Spiel) oder funktionieren nicht, wenn sie aus dem Chatrad ausgewählt werden
                          (z. B. Ping-Sprachzeilen, die ein Zielobjekt benötigen).
                          Kreuzen Sie das Häkchen an, um sie auf eigenes Risiko über die Einstellungen im Spiel auswählbar zu machen.

vc-delete-tooltip = Sprachbefehl aus diesem Menü löschen.
vc-enabled-tooltip = Ob dieser Sprachbefehl in den Einstellungen im Spiel auswählbar sein soll.
vc-count = { $count } von { $limit }
vc-error-duplicate = Dieser Sprachbefehl taucht mehrfach in diesem Menü auf.
                     Zwar ist dies erlaubt und technisch gesehen gültig, ist es möglicherweise ein Versehen.
vc-error-menu = Menüs dürfen nicht in anderen Menüs verschachtelt werden.

vc-item-can_heal = Kann heilen
vc-item-defend_lane = Pfad verteidigen ...
vc-item-going_in = Ich gehe rein
vc-item-good_job = Gut gemacht
vc-item-headed_to_lane = Bin unterwegs zum Pfad ...
vc-item-headed_to_shop_base = Bin unterwegs zur Basis
vc-item-help_with_idol = Mit Seelenurne helfen
vc-item-help = Hilfe
vc-item-need_heal = Brauche Heilung
vc-item-push_lane = Auf Pfad vorstoßen ...
vc-item-retreat = Rückzug
vc-item-sorry = Tut mir leid
vc-item-stay_together = Zusammenbleiben
vc-item-thanks = Danke
vc-item-need_plan = Was ist der Plan?
vc-item-youre_welcome = Gern geschehen

vc-item-defend_blue = Verteidige Blau
vc-item-defend_green = Verteidige Grün
vc-item-defend_purple = Verteidige Lila
vc-item-defend_yellow = Verteidige Gelb
vc-item-headed_to_blue = Gehe zu Blau
vc-item-heading_to_green = Gehe zu Grün
vc-item-headed_to_purple = Gehe zu Lila
vc-item-heading_to_yellow = Gehe zu Gelb
vc-item-push_blue = Blau angreifen
vc-item-push_green = Grün angreifen
vc-item-push_purple = Lila angreifen
vc-item-push_yellow = Gelb angreifen

vc-item-no = Nein!
vc-item-on_my_way = Bin unterwegs
vc-item-yes = Ja

vc-item-good_game_post_game_all_chat = Gutes Spiel [ALLE]
vc-item-good_job_post_game_all_chat = Gut gemacht (nach Spiel)
vc-item-thanks_post_game_all_chat = Danke (nach Spiel)
vc-item-well_played_post_game_all_chat = Gut gespielt (nach Spiel)
vc-item-missing = (Gegner) fehlt
vc-item-pinged_enemy_player = Ich sehe (Gegner)
vc-item-pinged_teammate = Vorsicht (Teamkollege)

# Custom Menus
cm-title = Eigene Menüs
cm-add = Eigenes Menü hinzufügen
cm-delete = Menü löschen
cm-default-name = Neues eigenes Menü
cm-name = Name:
cm-icon = Symbol:
cm-items = Sprachbefehle:
cm-items-empty-state = Sprachbefehle aus der linken Liste hierher ziehen, um sie zu diesem Menü hinzuzufügen.

# Dialogs
dialog-ok = OK
dialog-cancel = Abbrechen
dialog-reset-title = Konfiguration zurücksetzen?
dialog-reset-text = Möchten Sie alle Einstellungen auf ihre Standardwerte zurücksetzen?
                    Sie können das Chatrad-Add-on jederzeit deaktivieren, indem Sie die .vpk Datei entfernen oder umbenennen.
dialog-reset-ok = Alle Einstellungen zurücksetzen
dialog-unsaved-exit-title = Änderungen speichern?
dialog-unsaved-exit-text = Sie haben ungespeicherte Änderungen!
                           Bitte speichern Sie Ihre Konfiguration als VPK-Add-on, wenn Sie es verwenden möchten.
dialog-unsaved-exit-ok = Speichern und beenden...
dialog-unsaved-exit-quit = Ohne speichern beenden
dialog-unsaved-load-title = Änderungen speichern?
dialog-unsaved-load-text = Sie haben ungespeicherte Änderungen!
                           Bitte speichern Sie Ihre Konfiguration als VPK-Add-on, wenn Sie es verwenden möchten.
dialog-unsaved-load-ok = Speichern...
dialog-unsaved-load-continue = Änderungen verwerfen
dialog-about-title = Über
dialog-locate-title = Wählen Sie Ihren Deadlock Add-ons Ordner, um VPKs mit Chatrad-Konfigurationen zu suchen
dialog-load-title = VPK-Datei laden
dialog-save-title = VPK-Datei speichern
dialog-alert-title = Info
dialog-delete-menu-title = Eigenes Menü löschen
dialog-delete-menu-text = Möchten Sie dieses Menü löschen?
                          Alle vorgenommenen Änderungen gehen dauerhaft verloren.
dialog-delete-menu-ok = Löschen
dialog-vc-section-help-title = Hilfe
dialog-filter-vpk-addon = VPK-Addon
dialog-filter-vpk-file = VPK-Datei
dialog-filter-config = Chatrad-Konfiguration
dialog-custom-menu-limit-title = Über benutzerdefinierte Menüs
dialog-custom-menu-limit-text = Deadlock verfügt über Sprachbefehlsmenüs, die Sie im Chatrad zuweisen können (z.B. "Auf Pfad vorstoßen").
                                Mit diesem Tool können Sie benutzerdefinierte Menüs erstellen, die zur Liste der Chatrad-Einstellungen hinzugefügt werden.
                                
                                Seit dem 13. November 2024 gibt es in Deadlock einen Bug, weswegen nur ein einziges Menü gleichzeitig im Chat-Rad aktiv
                                sein kann. Obwohl das Tool die Erstellung mehrerer Menüs ermöglicht, können Sie derzeit aufgrund dieses Fehlers
                                nicht mehrere gleichzeitig verwenden.
alert-locate-no-vpks = Der ausgewählte Ordner scheint keine Add-on-VPKs zu enthalten.
                       Versuchen Sie einen Ordner wie steamapps/common/Deadlock/game/citadel/addons
alert-locate-results = { $count ->
    [0] Keines der Add-on-VPKs im ausgewählten Ordner enthält Chatrad-Konfigurationen.
    [1] { $vpks } enthält Ihre Chatrad-Konfiguration.
   *[other] Folgende { $count } VPKs enthalten Chatrad-Konfigurationen:
            { $vpks }
}
alert-invalid-file-extension = Datei hat keine gültige Dateierweiterung!
error-cli-generic = Das CLI-Tool konnte nicht ausgeführt werden.
                    Überprüfen Sie die Konsole für weitere Details und melden Sie dies als Problem auf GitHub.
error-cli-cant-fork = Die CLI-Anwendung konnte nicht gestartet werden.
                      Stellen Sie sicher, dass Sie das ZIP-Archiv von ChatLane extrahiert haben
                      und keine Dateien umbenannt, verschoben oder gelöscht haben.
error-cli-already-in-use = Auf die ausgewählte Datei kann nicht zugegriffen werden.
                           Stellen Sie sicher, dass Anwendungen mit möglichem Zugriff auf die Datei geschlossen sind
                           (z. B. Deadlock oder Source2Viewer).
error-cli-file-unrecognized = Die ausgewählte VPK-Datei enthält keine Chatrad-Konfiguration.
                              Sie können die Option „Datei -> Add-on-VPKs suchen...“ verwenden, um die richtige VPK zu finden.
