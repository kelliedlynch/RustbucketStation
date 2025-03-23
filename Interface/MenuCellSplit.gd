@tool
extends MenuCell

@export var icon: Texture2D:
	set(value):
		icon = value
		if not is_inside_tree(): await ready
		icon_rect.texture = value
		
@export var left_color: Color:
	set(value):
		left_color = value
		if not is_inside_tree(): await ready
		var style: StyleBoxFlat = left_panel.get_theme_stylebox("panel")
		style.bg_color = value
		
@export var right_color: Color:
	set(value):
		right_color = value
		if not is_inside_tree(): await ready
		var style: StyleBoxFlat = right_panel.get_theme_stylebox("panel")
		style.bg_color = value

@onready var icon_rect: TextureRect = find_child("Icon")
@onready var left_panel: PanelContainer = find_child("LeftPanel")
@onready var right_panel: PanelContainer = find_child("RightPanel")
@onready var left_margin_container: MarginContainer = find_child("LeftMarginContainer")
@onready var right_margin_container: MarginContainer = find_child("RightMarginContainer")

var shader_update_queued: bool = false

func _ready() -> void:
	
	#if not Engine.is_editor_hint():
	await ready
	await get_tree().process_frame
	#item_rect_changed.connect(set.bind("shader_updated_queued", true))
	var top_border = left_panel.get_theme_stylebox("panel").border_width_top
	icon_rect.custom_minimum_size = Vector2(left_panel.size.y - top_border, left_panel.size.y - top_border)
	_update_shader()
	item_rect_changed.connect(_update_shader)

#func _process(delta: float) -> void:
	#if shader_update_queued:
		#_update_shader()

func _update_shader():
	#if not is_inside_tree(): await ready
	#print(left_panel.size)
	var skew = ProjectSettings.get("shader_globals/menu_cell_skew").value
	var left_border = left_panel.get_theme_stylebox("panel").border_width_left
	var left_x_offset = (left_panel.size.y * tan(skew)) / 2 + left_border
	var right_x_offset = right_panel.size.y * tan(skew)

	left_margin_container.add_theme_constant_override("margin_left", left_x_offset/2)
	left_margin_container.add_theme_constant_override("margin_right", -left_x_offset/2 - left_border/2)
	right_margin_container.add_theme_constant_override("margin_left", right_x_offset)
	right_margin_container.add_theme_constant_override("margin_right", right_x_offset / 2)
	left_panel.material.set_shader_parameter("rect_size", left_panel.size)
	right_panel.material.set_shader_parameter("rect_size", right_panel.size)


#@onready var value_label: Label = find_child("ValueLabel")
