extends Node
class_name ThreadedProcess


signal done(result)

var thread: Thread


func _process(delta):
	if thread == null:
		return
	
	if thread.is_alive():
		return
	
	var result = thread.wait_to_finish()
	thread = null
	done.emit(result)
	queue_free()


func _exit_tree():
	if thread != null and thread.is_started():
		thread.wait_to_finish()
		thread = null


func execute(executable, arguments, read_stderr = false, open_console = false):
	thread = Thread.new()
	thread.start(threaded.bind([executable, arguments, read_stderr, open_console]))


func threaded(data):
	var output = []
	var exit_code = OS.execute(data[0], data[1], output, data[2], data[3])
	return [exit_code, output]
