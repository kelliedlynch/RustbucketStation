@tool
extends Container

@onready var text_label: Label = find_child("TextLabel")

@export var text: String:
	set(value):
		text = value
		if not is_inside_tree(): await ready
		text_label.text = text

func _get_minimum_size() -> Vector2:
	var children_size:Vector2
	for child in get_children():
		var min_size:Vector2 = child.get_minimum_size()
		
		if child.visible:
			children_size.x = max(children_size.x, min_size.x)
			children_size.y = max(children_size.y, min_size.y)
	
	return Vector2(children_size.y, children_size.x)

func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN:
		var s:Vector2 = size
		var i = 0
		for child in get_children():
			child.rotation = -PI / 4
			var child_size = child.get_minimum_size()
			child.position = Vector2(size.y * i, size.y)
			i += 1
			#child.size = Vector2(s.y, s.x)

	if what == NOTIFICATION_THEME_CHANGED:
		update_minimum_size()
