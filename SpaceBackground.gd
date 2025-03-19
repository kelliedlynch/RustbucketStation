@tool
extends Node2D

@onready var background: Sprite2D = find_child("NebulaBackground")
@onready var stars: Sprite2D = find_child("StarField")
@onready var blue_smoke_emitters: Node2D = find_child("BlueEmitters")
@onready var orange_smoke_emitters: Node2D = find_child("OrangeEmitters")
@onready var smoke_emitter: CPUParticles2D = find_child("SmokeEmitter")
@onready var smoke_emitter_2: CPUParticles2D = find_child("SmokeEmitter2")

@export var speed_factor: float = 1.0:
	set(value):
		speed_factor = value
		if not is_inside_tree(): await ready
		for child in blue_smoke_emitters.get_children():
			child.speed_scale = speed_factor
		for child in orange_smoke_emitters.get_children():
			child.speed_scale = speed_factor

var bg_rotate_tween: Tween
var bg_move_tween: Tween
var stars_rotate_tween: Tween
var stars_move_tween: Tween
var smoke_update_tween: Tween

var bg_rotate_factor: int
var smoke_rotate_factor: int
var star_rotate_factor: int

func _ready() -> void:
	var screen_size = get_viewport().size
	if Engine.is_editor_hint():
		screen_size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
	background.position = screen_size / 2
	stars.position = screen_size / 2
	_set_bg_rotation()
	_set_star_rotation()
	_set_layer_movement(background)
	_set_layer_movement(stars)
	#_set_layer_movement(smoke_emitter)
	_set_smoke_emission()
	for child in blue_smoke_emitters.get_children():
		_set_layer_movement(child)
	for child in orange_smoke_emitters.get_children():
		_set_layer_movement(child)
	
func _set_smoke_emission() -> void:
	for child: CPUParticles2D in blue_smoke_emitters.get_children():
		var angle: float = randf_range(0, 2 * PI)
		var vec = Vector2.from_angle(angle)
		child.direction = vec
		var grav_angle: float = randf_range(0, 2 * PI)
		var grav_vec: Vector2 = Vector2.from_angle(grav_angle)
		child.gravity = grav_vec
		var spread = randf_range(15, 40)
		child.spread = spread
	for child: CPUParticles2D in orange_smoke_emitters.get_children():
		var angle: float = randf_range(0, 2 * PI)
		var vec = Vector2.from_angle(angle)
		child.direction = vec
		var grav_angle: float = randf_range(0, 2 * PI)
		var grav_vec: Vector2 = Vector2.from_angle(grav_angle)  * randf_range(1, 100)
		var a = randf_range(-.01, .01)
		var b = randf_range(-.01, .01)
		var c = randf_range(24, 36)
		c = -c if randi() & 1 else c
		
		#child.orbit_velocity_max = max(a, b)
		#child.orbit_velocity_min = min(a, b)
		child.tangential_accel_max = c
		child.tangential_accel_min = c

	var tween = create_tween()
	tween.tween_interval(30 / speed_factor)
	tween.tween_callback(_set_smoke_emission)
	
func _set_bg_rotation() -> void:
	bg_rotate_factor = randi_range(80, 100)
	if randi() & 1: bg_rotate_factor = -bg_rotate_factor
	smoke_rotate_factor = bg_rotate_factor
	var tween = create_tween()
	tween.tween_interval(randi_range(45, 60))
	tween.tween_callback(_set_bg_rotation)
	
func _set_star_rotation() -> void:
	star_rotate_factor = randi_range(180, 220)
	if randi() & 1: star_rotate_factor = -star_rotate_factor
	var tween = create_tween()
	tween.tween_interval(randi_range(26, 40))
	tween.tween_callback(_set_star_rotation)
	
func _set_layer_movement(layer: Node2D):
	#var screen_size = get_viewport().size
	#if Engine.is_editor_hint():
	var screen_size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
	var h = screen_size.y
	var x = randi_range(h / 2, screen_size.x - h / 2)
	var y = randi_range(0, h)
	if layer is CPUParticles2D:
		x = randi_range(0, screen_size.x)
		y = randi_range(0, screen_size.y)
	var new_pos = Vector2(x, y)
	var distance = layer.position.distance_to(new_pos)
	var speed = randi_range(6, 9) * speed_factor
	var duration = distance / speed
	var tween = create_tween()
	tween.tween_property(layer, "position", new_pos, duration)
	tween.tween_callback(_set_layer_movement.bind(layer))

func _process(delta: float) -> void:
	background.rotate(delta / bg_rotate_factor * speed_factor)
	#smoke_emitter.rotate(delta / bg_rotate_factor)
	stars.rotate(delta / star_rotate_factor * speed_factor)
