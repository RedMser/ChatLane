extends Object
class_name Utils


static func limit_string(string: String, length := 60) -> String:
	const ellipsis = "..."
	assert(length > ellipsis.length())
	if string.length() <= length:
		return string
	return string.left(length - ellipsis.length()) + ellipsis
