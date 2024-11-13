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
	
	rtl.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
	rtl.push_font_size(30)
	rtl.push_meta("https://github.com/redmser/chatlane")
	rtl.add_text("ChatLane\n")
	rtl.pop() # meta
	rtl.pop() # font_size
	rtl.add_text("\n\n")
	rtl.add_image(preload("res://logo.png"))
	rtl.add_text("\n\n")
	rtl.pop() # center
	rtl.push_font_size(20)
	rtl.add_text("Developed by RedMser, released under MIT license\n")
	rtl.pop() # font_size
	rtl.add_text("For more information on licensing, usage and third-party software, see the repository or the included README.md file.\n\n")
	
	rtl.push_font_size(20)
	rtl.add_text("Godot Engine license info\n\n")
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
		rtl.add_text("%s (c) %s licensed under %s\n" % [c.name, ", ".join(cc), ", ".join(cl)])
	
	rtl.add_text("\n\n\n")
	
	var li = Engine.get_license_info()
	for license in li.keys():
		rtl.push_font_size(20)
		rtl.add_text("%s\n\n" % license)
		rtl.pop() # font_size
		rtl.add_text("%s\n\n" % li[license])
