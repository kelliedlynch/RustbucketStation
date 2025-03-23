@tool
extends ProgressBar
class_name NeedsBar

#@onready var progress_bar: ProgressBar = find_child("ProgressBar")
#@export var value: int = 100
	#set(val):
		#value = val
		#if not is_inside_tree(): await ready
		#progress_bar.value = val
#@export var slant: float = 0.8
@export var icon: Texture2D:
	set(value):
		icon = value
		if not is_inside_tree(): await ready
		icon_rect.texture = value

@onready var percent_label: Label = find_child("PercentLabel")
@onready var icon_rect: TextureRect = find_child("IconTexture")

func _ready() -> void:
	value_changed.connect(_update_bar)
	item_rect_changed.connect(_update_bar)
	#if not Engine.is_editor_hint():
	await get_tree().process_frame
	#await ready
	_update_bar(value)
	
func _resize_label():
	percent_label.custom_minimum_size.x = size.y
	
func _update_bar(val: float = value):
	#material.set_shader_parameter("slant", slant)
	material.set_shader_parameter("rect_size", size)
	#percent_label.material.set_shader_parameter("rotation", slant)
	percent_label.material.set_shader_parameter("container_size", size)
	percent_label.material.set_shader_parameter("rect_size", percent_label.size)
	percent_label.text = str(int(val)) + "%"
	var stylebox = get_theme_stylebox("fill").duplicate()
	if val < 25:
		stylebox.bg_color = Color.RED
		#stylebox.border_color = Color.DARK_RED
	elif val < 50:
		stylebox.bg_color = Color.DARK_ORANGE
		#stylebox.border_color = Color.CHOCOLATE
	elif val < 75:
		stylebox.bg_color = Color.YELLOW
		#stylebox.border_color = Color.GOLDENROD
	else:
		stylebox.bg_color = Color.LIME_GREEN
		#stylebox.border_color = Color.WEB_GREEN
	add_theme_stylebox_override("fill", stylebox)
