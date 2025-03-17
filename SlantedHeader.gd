@tool
extends Container

@onready var text_label: Label = find_child("TextLabel")
@onready var panel: PanelContainer = find_child("StylePanel")

var skew_angle: float = PI / 4

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
	var v_actual = ceil(sin(skew_angle) * children_size.x)
	var v_offset = ceil(sin(skew_angle) / (1 / children_size.y))
	#return Vector2(max(children_size.y, size.x), max(children_size.x, size.y))
	return Vector2(children_size.y, v_actual + v_offset)

func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN:
		var s:Vector2 = size
		var i = 0
		var max_height = 0
		var v_offset = ceil(sin(skew_angle) / (1 / size.x) * .75)
		for child in get_children():
			child.rotation = -skew_angle
			var child_size = child.get_minimum_size()
			#var v_actual = sin(skew_angle) * size.y
			#max_height = max(v_actual, max_height)
			max_height = max(child.size.x, max_height)
			
			child.position = Vector2(size.y * i + size.x * .75, size.y - v_offset / .75)
			#child.size = Vector2(size.y, size.x)
			var style = panel.get_theme_stylebox("panel")
			style.expand_margin_left = v_offset
			style.expand_margin_right = v_offset
			#style.set_skew(-Vector2((1/cos(-skew_angle) + 1/sin(-skew_angle)), 0))
			
			i += 1
		for child in get_children():
			child.size.x = size.y + v_offset
			#child.size = Vector2(s.y, s.x)

	if what == NOTIFICATION_THEME_CHANGED:
		update_minimum_size()
