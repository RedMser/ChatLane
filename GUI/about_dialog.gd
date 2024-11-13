extends Window

var loaded = false

func _ready():
	visibility_changed.connect(func():
		if visible and !loaded:
			load_rtl()
	)
	close_requested.connect(func(): hide())


func load_rtl():
	var rtl: RichTextLabel = $MarginContainer/RichTextLabel
	rtl.meta_clicked.connect(func(data):
		OS.shell_open(str(data))
	)
	
	var app_name = ProjectSettings.get_setting("application/config/name")
	rtl.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
	rtl.push_font_size(30)
	rtl.push_meta("https://github.com/redmser/chatlane")
	rtl.add_text(app_name + "\n")
	rtl.pop() # meta
	rtl.pop() # font_size
	rtl.add_text("\n\n")
	rtl.add_image(preload("res://logo.png"))
	rtl.add_text("\n\n")
	rtl.pop() # center
	rtl.push_font_size(20)
	rtl.add_text(tr("about-1") + "\n")
	rtl.pop() # font_size
	rtl.add_text(tr("about-2") + "\n\n")
	
	rtl.push_font_size(20)
	rtl.add_text("Godot Engine\n\n")
	rtl.pop() # font_size
	rtl.add_text(Engine.get_license_text())
	
	rtl.add_text("\n\n\n")
	for c in Engine.get_copyright_info():
		var cc = []
		var cl = []
		for p in c.parts:
			if !(p.copyright in cc):
				cc.append_array(p.copyright)
			if !(p.license in cl):
				cl.append(p.license)
		rtl.add_text(
			tr(TranslationFluent.args("about-copyright", {
				"name": c.name, "copyright": ", ".join(cc), "license": ", ".join(cl)
			})) + "\n"
		)
	
	rtl.add_text("\n\n\n")
	
	var li = Engine.get_license_info()
	for license in li.keys():
		rtl.push_font_size(20)
		rtl.add_text("%s\n\n" % license)
		rtl.pop() # font_size
		rtl.add_text("%s\n\n" % li[license])
