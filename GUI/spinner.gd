@tool
extends ProgressBar


var how_long_visible := 0.0
@export var tween_duration = 0.35
@export var min_visible_duration = 0.5


func _ready() -> void:
	visibility_changed.connect(update_processing)
	update_processing()
	tween_a()


func _process(delta: float) -> void:
	how_long_visible += delta


func tween_a():
	fill_mode = ProgressBar.FILL_BEGIN_TO_END
	value = 0.0
	var t = create_tween()
	t.set_ease(Tween.EASE_IN)
	t.set_trans(Tween.TRANS_QUAD)
	t.tween_property(self, "value", 100.0, tween_duration)
	t.tween_callback(tween_b)


func tween_b():
	fill_mode = ProgressBar.FILL_END_TO_BEGIN
	value = 1000.0
	var t = create_tween()
	t.set_ease(Tween.EASE_OUT)
	t.set_trans(Tween.TRANS_QUAD)
	t.tween_property(self, "value", 0.0, tween_duration)
	t.tween_callback(tween_a)


func update_processing():
	process_mode = Node.PROCESS_MODE_INHERIT if visible else Node.PROCESS_MODE_DISABLED


func set_visible_soon(visibility: bool):
	if visibility:
		how_long_visible = 0.0
		show()
	else:
		var wait_time = min_visible_duration - how_long_visible
		if wait_time > 0.0:
			await get_tree().create_timer(wait_time).timeout
		hide()
