@tool
extends Control
class_name MenuCell

@export var header_stylebox: StyleBox = preload("uid://du31smfdmdgsb")
@export var value_stylebox: StyleBox = preload("uid://beftae1rdoriu")
@export var label_settings: LabelSettings = preload("uid://24fpsfd1ml7f"):
	set(value):
		label_settings = value
		if not is_inside_tree(): await ready
		value_label.label_settings = value
		notify_property_list_changed()

@onready var value_label: Label = find_child("ValueLabel")
@onready var main_panel: PanelContainer = find_child("MainPanel")
@onready var margin_container: MarginContainer = find_child("MarginContainer")

@export var cell_type: CellType = CellType.Value:
	set(value):
		cell_type = value
		if not is_inside_tree(): await ready
		match value:
			CellType.Header:
				if main_panel:
					main_panel.add_theme_stylebox_override("panel", header_stylebox)
				label_settings = load("uid://cct1160ti5774")
			_:
				if main_panel:
					main_panel.add_theme_stylebox_override("panel", value_stylebox)
				label_settings = load("uid://24fpsfd1ml7f")
		notify_property_list_changed()

@export var text: String = "":
	set(value):
		text = value
		if not is_inside_tree(): await ready
		value_label.text = value

func _ready() -> void:
	await ready
	await get_tree().process_frame
	#item_rect_changed.connect(_update_shader)
	_update_shader()

func _update_shader():
	if not is_inside_tree(): await ready
	var skew = ProjectSettings.get("shader_globals/menu_cell_skew").value
	var x_offset = size.y * tan(skew) - main_panel.get_theme_stylebox("panel").border_width_left
	
	margin_container.add_theme_constant_override("margin_left", x_offset)
	#margin_container.add_theme_constant_override("margin_right", x_offset/2)
	main_panel.material.set_shader_parameter("rect_size", size)

enum CellType {
	Header,
	Value
}
