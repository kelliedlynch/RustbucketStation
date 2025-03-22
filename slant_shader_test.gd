extends Control

@onready var bar_bg: ColorRect = find_child("BarBackground")
@onready var bar_fill: ColorRect = find_child("BarFill")

func _ready() -> void:
	bar_bg.material.set_shader_parameter("rect_size", bar_bg.size)
	bar_fill.material.set_shader_parameter("rect_size", bar_fill.size)
	#bar_bg.material.set_shader_parameter("rect_size", bar_bg.size)
