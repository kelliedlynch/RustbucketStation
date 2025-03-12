@tool
extends TextureRect

var lines: Array[Line2D] = []
var line_width: int = 3
var line_spacing: int = 8

@onready var lines_parent: Node = find_child("Lines")

@export var bg_color: Color = Color.from_string("152c54", Color.MIDNIGHT_BLUE):
	set(value):
		bg_color = value
		if not is_inside_tree(): await ready
		self_modulate = value
@export var line_color: Color = Color.from_string("1a3462", Color.DARK_BLUE):
	set(value):
		line_color = value
		if not is_inside_tree(): await ready
		lines_parent.modulate = value

func _ready() -> void:
	await ready
	draw_lines()

func draw_lines() -> void:
	var window_size = size
	for child in lines_parent.get_children():
		child.queue_free()
	for i in range(-2000, 3000, line_width + line_spacing):
		var line = Line2D.new()
		line.width = line_width
		line.add_point(Vector2(-2000, 0))
		line.add_point(Vector2(5000, 0))
		line.position = Vector2(0, i)
		#line.self_modulate = line_color
		lines.append(line)
		lines_parent.add_child(line)
		line.owner = lines_parent
