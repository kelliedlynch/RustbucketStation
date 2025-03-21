extends PanelContainer
class_name NeedsBar

@onready var progress_bar: ProgressBar = find_child("ProgressBar")
@export var value: int = 100:
	set(val):
		value = val
		if not is_inside_tree(): await ready
		progress_bar.value = val

func _ready() -> void:
	progress_bar.value_changed.connect(_update_bar)
	
func _update_bar(val: float):
	var stylebox = progress_bar.get_theme_stylebox("fill").duplicate()
	if val < 25:
		stylebox.bg_color = Color.RED
		stylebox.border_color = Color.DARK_RED
	elif val < 50:
		stylebox.bg_color = Color.DARK_ORANGE
		stylebox.border_color = Color.CHOCOLATE
	elif val < 75:
		stylebox.bg_color = Color.YELLOW
		stylebox.border_color = Color.GOLDENROD
	else:
		stylebox.bg_color = Color.LIME_GREEN
		stylebox.border_color = Color.WEB_GREEN
	progress_bar.add_theme_stylebox_override("fill", stylebox)
