@tool
extends MarginContainer
class_name MenuCell

@export var text: String = "":
	set(value):
		text = value
		if not is_inside_tree(): await ready
		value_label.text = value
		
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
		notify_property_list_changed()
		
@export_group("Text Format")
		
@export var text_variation: BaseTheme.LabelVariation = BaseTheme.LabelVariation.LabelNormal:
	set(value):
		text_variation = value
		if not is_inside_tree(): await ready
		value_label.theme_type_variation = BaseTheme.LabelVariation.keys()[value]

@export var font_size: BaseTheme.FontSize = BaseTheme.FontSize.MenuNormal:
	set(value):
		font_size = value
		if not is_inside_tree(): await ready
		value_label.add_theme_font_size_override("font_size", value)
		
@export_enum("Left:%s" % HORIZONTAL_ALIGNMENT_LEFT, "Center:%s" % HORIZONTAL_ALIGNMENT_CENTER, "Right:%s" % HORIZONTAL_ALIGNMENT_RIGHT)\
			 var text_align: int = HORIZONTAL_ALIGNMENT_CENTER:
	set(value):
		text_align = value
		if not is_inside_tree(): await ready
		value_label.horizontal_alignment = value
		
@export_subgroup("Text Margins")
@export var margin_left: int:
	set(value):
		margin_left = value
		if not is_inside_tree(): await ready
		text_margins.add_theme_constant_override("margin_left", value)
@export var margin_right: int:
	set(value):
		margin_right = value
		if not is_inside_tree(): await ready
		text_margins.add_theme_constant_override("margin_right", value)
@export var margin_top: int:
	set(value):
		margin_top = value
		if not is_inside_tree(): await ready
		text_margins.add_theme_constant_override("margin_bottom", value)
@export var margin_bottom: int:
	set(value):
		margin_left = value
		if not is_inside_tree(): await ready
		text_margins.add_theme_constant_override("margin_left", value)

@onready var value_label: Label = find_child("ValueLabel")
@onready var texture_panel: PanelContainer = find_child("TexturePanel")
@onready var icon_rect: TextureRect = find_child("IconTexture")
@onready var icon_container: Container = find_child("IconContainer")
@onready var cell_contents: MarginContainer = find_child("CellContents")
@onready var text_margins: MarginContainer = find_child("TextMargins")


		
func _ready() -> void:
	item_rect_changed.connect(_resize_for_skew)
	pass

#func _process(delta: float) -> void:
	#_resize_for_skew()
		
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

enum CellType {
	Header,
	Value
}
