@tool
extends PanelContainer
class_name MenuCell

@export var header_stylebox: StyleBox = preload("uid://du31smfdmdgsb")
@export var value_stylebox: StyleBox = preload("uid://beftae1rdoriu")
@export var label_settings: LabelSettings = preload("uid://24fpsfd1ml7f"):
	set(value):
		label_settings = value
		if not is_inside_tree(): await ready
		text_label.label_settings = value
		notify_property_list_changed()

@onready var text_label: Label = find_child("TextLabel")

@export var cell_type: CellType = CellType.Value:
	set(value):
		cell_type = value
		match value:
			CellType.Header:
				add_theme_stylebox_override("panel", header_stylebox)
				label_settings = load("uid://cct1160ti5774")
			_:
				add_theme_stylebox_override("panel", value_stylebox)
				label_settings = load("uid://24fpsfd1ml7f")
		notify_property_list_changed()

@export var text: String = "":
	set(value):
		if not is_inside_tree(): await ready
		text = value
		text_label.text = value
		notify_property_list_changed()

enum CellType {
	Header,
	Value
}
