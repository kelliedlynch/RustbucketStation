@tool
extends Control

@export var frame_size: Vector2 = Vector2(500, 300):
	set(value):
		frame_size = value
		if not is_inside_tree(): await ready
		base_frame.size = value

@onready var base_frame: Container = find_child("BaseFrame")
@onready var frame_container: Container = find_child("FrameContainer")
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
		#panel.stretch_mode = TextureRect.stre
		#match cn:
			#"TopLeftCorner":
				#panel.set_anchors_preset(Control.PRESET_TOP_LEFT)
			#"TopRightCorner":
				#panel.set_anchors_preset(Control.PRESET_TOP_RIGHT)
		#style.set_texture_margin_all(max(tex.get_size().x, tex.get_size().y))
		panel.add_theme_stylebox_override("panel", style)
		#panel.show_behind_parent = true
		frame_container.add_child(panel)
