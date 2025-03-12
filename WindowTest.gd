@tool
extends Node2D

var lines: Array[Line2D] = []
var line_width: int = 3
var line_spacing: int = 8

@onready var ani: AnimationPlayer = find_child("AnimationPlayer")

@onready var background_layer: Node = find_child("Background")
@onready var lines_parent: Node = find_child("Lines")
@onready var menu_items: VBoxContainer = find_child("MenuItems")

@export var bg_color: Color:
	set(value):
		bg_color = value
		if not is_inside_tree(): await ready
		background_layer.self_modulate = value
@export var line_color: Color:
	set(value):
		line_color = value
		if not is_inside_tree(): await ready
		lines_parent.modulate = value
		#for line in lines_parent.get_children():
			#line.self_modulate = value

func _ready() -> void:
	await ready
	draw_screen()
	ani.play("RESET")
	for i in 12:
		var item = load("res://UnitMenuItem/UnitMenuRow.tscn").instantiate()
		item.character = Character.new(randi_range(1, 9))
		menu_items.add_child(item)
	
	#cycle_animations()
	#cycle_alpha()
	
func draw_screen() -> void:
	var window_size = background_layer.size
	for child in lines_parent.get_children():
		child.queue_free()
	for i in range(-2000, 3000, line_width + line_spacing):
		var line = Line2D.new()
		line.width = line_width
		line.add_point(Vector2(-2000, 0))
		line.add_point(Vector2(5000, 0))
		line.position = Vector2(0, i)
		#line.self_modulate = line_color
		lines.append(line)
		lines_parent.add_child(line)
		line.owner = lines_parent

func cycle_animations() -> void:
	ani.play("RESET")
	ani.advance(0)
	var weights = []
	var library = ani.get_animation_library("ScreenBackground")
	var animations = library.get_animation_list()
	for ani_name in animations:
		if ani_name == "line_scroll":
			weights.append(10)
		else:
			weights.append(1)
	var to_play = Utility.rng.rand_weighted(weights)
	var times = randf_range(2, 4)
	if animations[to_play] == "line_scroll":
		times = 3
	var ani_dur = library.get_animation(animations[to_play]).length
	ani.play("ScreenBackground/" + animations[to_play])
	var tween = create_tween()
	tween.tween_interval(ani_dur * times)
	tween.tween_callback(cycle_animations)
	tween.play()
	
func cycle_alpha() -> void:
	var delay = randf_range(5, 10)
	var times = randi_range(3, 8)
	var color: Color = lines_parent.modulate
	var alpha_shift = randf_range(-.15, .15)
	var shifted = Color(color, color.a + alpha_shift)
	await get_tree().create_timer(delay).timeout
	var tween = create_tween()
	#tween.tween_interval(delay)
	tween.set_loops(times)
	tween.tween_property(lines_parent, "modulate", shifted, .05)
	tween.tween_property(lines_parent, "modulate", color, .05)
	tween.play()
	await tween.finished
	cycle_alpha()
