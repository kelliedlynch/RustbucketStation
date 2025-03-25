@tool
extends MarginContainer
class_name MenuCell

#@export var header_stylebox: StyleBox = preload("uid://du31smfdmdgsb")
#@export var value_stylebox: StyleBox = preload("uid://beftae1rdoriu")
@export var label_settings: LabelSettings = preload("uid://24fpsfd1ml7f"):
	set(value):
		label_settings = value
		if not is_inside_tree(): await ready
		value_label.label_settings = value
		notify_property_list_changed()

@onready var value_label: Label = find_child("ValueLabel")

@export var show_icon: bool = false:
	set(value):
		show_icon = value
		if not is_inside_tree(): await ready
		icon_container.visible = value
		notify_property_list_changed()

@export var icon: Texture2D:
	set(value):
		icon = value
		if not is_inside_tree(): await ready
		icon_rect.texture = value
		icon_outline.texture = value
		notify_property_list_changed()

@onready var texture_panel: PanelContainer = find_child("TexturePanel")
@onready var icon_rect: TextureRect = find_child("IconTexture")
@onready var icon_outline: TextureRect = find_child("IconOutline")
@onready var icon_container: Container = find_child("IconContainer")
@onready var cell_contents: MarginContainer = find_child("CellContents")

@export var cell_type: CellType = CellType.Value:
	set(value):
		cell_type = value
		#if not is_inside_tree(): await ready
		#match value:
			#CellType.Header:
				#if main_panel:
					#main_panel.add_theme_stylebox_override("panel", header_stylebox)
				#label_settings = load("uid://cct1160ti5774")
			#_:
				#if main_panel:
					#main_panel.add_theme_stylebox_override("panel", value_stylebox)
				#label_settings = load("uid://24fpsfd1ml7f")
		#notify_property_list_changed()

@export var text: String = "":
	set(value):
		text = value
		if not is_inside_tree(): await ready
		value_label.text = value

func _ready() -> void:
	await ready
	#await get_tree().process_frame
	#item_rect_changed.connect(_update_shader)
	#_update_shader()
	#main_panel.item_rect_changed.connect(_update_shader)

func _process(delta: float) -> void:
	if not texture_panel: 
		print("bad frame")
		return
	_resize_for_skew()
		
func _resize_for_skew() -> void:
	var style: StyleBoxFlat = texture_panel.get_theme_stylebox("panel")
	var skew = style.skew.x
	var x_offset_right = round((size.y * tan(skew)) / 2.0)
	var x_offset_left = 0
	if not show_icon:
		x_offset_left = x_offset_right
		var border_left: float = style.border_width_left
		#border_left += border_left * tan(skew)
		x_offset_left += border_left
	cell_contents.add_theme_constant_override("margin_left", round(x_offset_left))
	cell_contents.add_theme_constant_override("margin_right", round(x_offset_right))

#func _update_shader():
	#if not is_inside_tree(): await ready
	#var skew = ProjectSettings.get("shader_globals/menu_cell_skew").value
	#var x_offset = main_panel.size.y * tan(skew) - main_panel.get_theme_stylebox("panel").border_width_left
	#
	#margin_container.add_theme_constant_override("margin_left", x_offset)
	##margin_container.add_theme_constant_override("margin_right", x_offset/2)
	#main_panel.material.set_shader_parameter("rect_size", size)

enum CellType {
	Header,
	Value
}
