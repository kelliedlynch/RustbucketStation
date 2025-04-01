@tool
extends Control
class_name NeedsBar

@export var value: int = 100:
	set(val):
		value = val
		if not is_inside_tree(): await ready
		progress_bar.value = val
		
@export var icon: Texture2D:
	set(value):
		icon = value
		if not is_inside_tree(): await ready
		icon_rect.texture = value

@onready var percent_label: Label = find_child("PercentLabel")
@onready var icon_rect: TextureRect = find_child("IconTexture")
@onready var progress_bar: ProgressBar = find_child("ProgressBar")
@onready var canvas_group: Node2D = find_child("CanvasGroup")

func _ready() -> void:
	progress_bar.value_changed.connect(_update_bar)
	item_rect_changed.connect(_update_bar)
	await get_tree().process_frame

	_update_bar(progress_bar.value)
	
func _resize_label():
	percent_label.custom_minimum_size.x = size.y
	
func _update_bar(val: float = progress_bar.value):
	progress_bar.size = Vector2(progress_bar.size.x, round(size.y / cos(canvas_group.skew)))
	canvas_group.skew = ProjectSettings.get_setting("shader_globals/menu_cell_skew").value

	canvas_group.position = Vector2(size.y * tan(canvas_group.skew), 0)

	var stylebox = progress_bar.get_theme_stylebox("fill").duplicate()
	if val < 25:
		stylebox.bg_color = Color.RED
	elif val < 50:
		stylebox.bg_color = Color.DARK_ORANGE
	elif val < 75:
		stylebox.bg_color = Color.YELLOW
	else:
		stylebox.bg_color = Color.LIME_GREEN
	progress_bar.add_theme_stylebox_override("fill", stylebox)
