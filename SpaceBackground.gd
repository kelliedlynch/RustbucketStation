@tool
extends Node2D

@onready var background: Sprite2D = find_child("NebulaBackground")
@onready var stars: Sprite2D = find_child("StarField")

var bg_rotate_tween: Tween
var bg_move_tween: Tween
var stars_rotate_tween: Tween
var stars_move_tween: Tween

var bg_rotate_factor: int
var star_rotate_factor: int

func _ready() -> void:
	_set_bg_rotation()
	_set_star_rotation()
	_set_layer_movement(background)
	_set_layer_movement(stars)
	
func _set_bg_rotation() -> void:
	bg_rotate_factor = randi_range(64, 80)
	if randi() & 1: bg_rotate_factor = -bg_rotate_factor
	var tween = create_tween()
	tween.tween_interval(randi_range(45, 60))
	tween.tween_callback(_set_bg_rotation)
	
func _set_star_rotation() -> void:
	star_rotate_factor = randi_range(120, 150)
	if randi() & 1: star_rotate_factor = -star_rotate_factor
	var tween = create_tween()
	tween.tween_interval(randi_range(26, 40))
	tween.tween_callback(_set_star_rotation)
	
func _set_layer_movement(layer: Sprite2D):
	var screen_size = get_viewport().size
	if Engine.is_editor_hint():
		screen_size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
	var h = screen_size.y
	var x = randi_range(h / 2, screen_size.x - h / 2)
	var y = randi_range(0, h)
	var new_pos = Vector2(x, y)
	var distance = layer.position.distance_to(new_pos)
	var speed = randi_range(10, 20)
	var duration = distance / speed
	var tween = create_tween()
	tween.tween_property(layer, "position", new_pos, duration)
	tween.tween_callback(_set_layer_movement.bind(layer))

func _process(delta: float) -> void:
	background.rotate(delta / bg_rotate_factor)
	stars.rotate(delta / star_rotate_factor)
