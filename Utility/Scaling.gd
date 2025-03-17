extends Node

var retina_scale: float

func _ready() -> void:
	retina_scale = DisplayServer.screen_get_scale()
	rescale_for_retina()
	
func rescale_for_retina():
	var window = get_window()
	if (window.content_scale_factor != retina_scale):
		#we need to change, calculate the relative change in scale
		var relative_scale:float = retina_scale / window.content_scale_factor
		#apply the change, as well as resizing window based on previous scale and relative scale
		window.content_scale_factor = retina_scale
		window.size = window.size*relative_scale
