@tool
extends Control

@export var bg_color: Color = Color.from_string("152c54", Color.MIDNIGHT_BLUE):
	set(value):
		bg_color = value
		if not is_inside_tree(): await ready
		background.bg_color = value
@export var line_color: Color = Color.from_string("1a3462", Color.DARK_BLUE):
	set(value):
		line_color = value
		if not is_inside_tree(): await ready
		background.line_color = value

@onready var base_frame: Container = find_child("BaseFrame")
@onready var frame_container: Container = find_child("FrameContainer")
@onready var background: Control = find_child("Background")
#@onready var overlay: TextureRect = find_child("GrungeOverlay")

func _ready() -> void:
	#var style: StyleBox = top_left_corner.get_theme_stylebox("panel").duplicate()
	build_corner_textures()

func build_corner_textures():
	var corner_names = ["TopLeftCorner", "TopRightCorner", "BottomLeftCorner", "BottomRightCorner"]
	for cn in corner_names:
		var files = ResourceLoader.list_directory("res://Graphics/FrameBuilder/Decoration/" + cn)
		var filename = files[randi_range(0, files.size() - 1)]
		var tex: CompressedTexture2D = load("res://Graphics/FrameBuilder/Decoration/" + cn + "/" + filename)
		var panel = Panel.new()
		var style = StyleBoxTexture.new()
		style.texture = tex
		style.set_texture_margin_all(120)
		panel.add_theme_stylebox_override("panel", style)
		frame_container.add_child(panel)
