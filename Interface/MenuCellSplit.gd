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
#@onready var value_label: Label = find_child("ValueLabel")
